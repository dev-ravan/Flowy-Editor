import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flowy_editor/Model/template_list.dart';
import 'package:flowy_editor/Screens/Editor/converter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;

import 'Editor/editor.dart';

enum ExportFileType {
  documentJson,
  markdown,
  html,
  delta,
}

extension on ExportFileType {
  String get extension {
    switch (this) {
      case ExportFileType.documentJson:
        return 'json';
      case ExportFileType.delta:
        return 'json';
      case ExportFileType.markdown:
        return 'md';
      case ExportFileType.html:
        return 'html';
    }
  }
}

class JunkProvider extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  String? templateMarkdown;

  saveTemplate(
      {required EditorState editorState, required BuildContext context}) {
    templateMarkdown = documentToMarkdown(editorState.document);
    templateList.add(TemplateList(
        template: templateMarkdown!, templateName: titleController.text));
    notifyListeners();
    Navigator.pop(context);
    titleController.clear();
  }

// Load editor
  Future<void> _loadEditor(
    Future<String> jsonString,
    EditorState editorState,
    Widget Function(BuildContext) widgetBuilder, {
    TextDirection textDirection = TextDirection.ltr,
  }) async {
    final completer = Completer<void>();

    widgetBuilder = (context) => Editor(
          jsonString: jsonString,
          onEditorStateChange: (state) {
            editorState = state;
          },
          textDirection: textDirection,
        );
    notifyListeners();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      completer.complete();
    });

    return completer.future;
  }

// Import system files==========================================================>
  void importFile(
      BuildContext context,
      ExportFileType fileType,
      EditorState editorState,
      Widget Function(BuildContext) widgetBuilder) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: [fileType.extension],
      type: FileType.custom,
    );
    var plainText = '';
    if (!kIsWeb) {
      final path = result?.files.single.path;
      if (path == null) {
        return;
      }
      plainText = await File(path).readAsString();
    } else {
      final bytes = result?.files.first.bytes;
      if (bytes == null) {
        return;
      }
      plainText = const Utf8Decoder().convert(bytes);
    }

    String jsonString = '';
    switch (fileType) {
      case ExportFileType.documentJson:
        jsonString = plainText;
        break;
      case ExportFileType.markdown:
        jsonString = jsonEncode(markdownToDocument(plainText).toJson());
        break;
      case ExportFileType.delta:
        final delta = Delta.fromJson(jsonDecode(plainText));
        final document = quillDeltaEncoder.convert(delta);
        jsonString = jsonEncode(document.toJson());
        break;
      case ExportFileType.html:
        final htmlString = await rootBundle.loadString('assets/example.html');
        final html = htmlToDocument(htmlString);
        jsonString = Future<String>.value(
          jsonEncode(
            html.toJson(),
          ),
        ).toString();
        break;
    }

    _loadEditor(Future<String>.value(jsonString), editorState, widgetBuilder);
  }

// Import Template File ========================================================>
  void importTemplate(
      EditorState editorState, Widget Function(BuildContext) widgetBuilder,
      {required String text}) async {
    String jsonString = '';
    jsonString = jsonEncode(markdownToDocument(text).toJson());

    _loadEditor(Future<String>.value(jsonString), editorState, widgetBuilder);
  }

// Export Files ================================================================>
  void exportFile(ExportFileType fileType, EditorState editorState,
      BuildContext context) async {
    var result = '';

    switch (fileType) {
      case ExportFileType.documentJson:
        result = jsonEncode(editorState.document.toJson());
        break;
      case ExportFileType.markdown:
        result = documentToMarkdown(editorState.document);
        break;
      case ExportFileType.html:
      case ExportFileType.delta:
        throw UnimplementedError();
    }

    if (kIsWeb) {
      final blob = html.Blob([result], 'text/plain', 'native');
      html.AnchorElement(
        href: html.Url.createObjectUrlFromBlob(blob).toString(),
      )
        ..setAttribute('download', 'document.${fileType.extension}')
        ..click();
    } else if (PlatformExtension.isMobile) {
      final appStorageDirectory = await getApplicationDocumentsDirectory();

      final path = File(
        '${appStorageDirectory.path}/${DateTime.now()}.${fileType.extension}',
      );
      await path.writeAsString(result);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'This document is saved to the ${appStorageDirectory.path}',
          ),
        ),
      );
    } else {
      // for desktop
      final path = await FilePicker.platform.saveFile(
        fileName: 'document.${fileType.extension}',
      );
      if (path != null) {
        await File(path).writeAsString(result);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('This document is saved to the $path'),
          ),
        );
      }
    }
  }
}

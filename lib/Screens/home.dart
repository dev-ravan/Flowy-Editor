import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flowy_editor/Components/dialogs.dart';
import 'package:flowy_editor/Screens/Editor/converter.dart';
import 'package:flowy_editor/Screens/junk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flowy_editor/Components/buttons.dart';
import 'package:flowy_editor/Components/dropdown.dart';
import 'package:flowy_editor/Components/sizes.dart';
import 'package:flowy_editor/Screens/preview.dart';
import 'package:flowy_editor/Theme/palette.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

import 'Editor/editor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textDirection = TextDirection.ltr;
  late WidgetBuilder _widgetBuilder;
  late EditorState _editorState;
  late Future<String> _jsonString;
  String? selectedTemplate;
  String? selctedTemplateDetails;

  @override
  void initState() {
    super.initState();

    _jsonString = PlatformExtension.isDesktopOrWeb
        ? rootBundle.loadString('assets/mobile_example.json')
        : rootBundle.loadString('assets/example.json');

    _widgetBuilder = (context) => Editor(
          jsonString: _jsonString,
          onEditorStateChange: (state) {
            _editorState = state;
          },
        );
  }

  @override
  void dispose() {
    _editorState.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();

    _widgetBuilder = (context) => Editor(
          jsonString: _jsonString,
          onEditorStateChange: (state) {
            _editorState = state;
            _jsonString = Future.value(
              jsonEncode(_editorState.document.toJson()),
            );
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JunkProvider>();
    return Scaffold(
      backgroundColor: palette.secondaryGrey,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: templateDropdown()),
                    ],
                  ),
                  gap16,
                  Expanded(child: _widgetBuilder(context)),
                  gap16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconElevatedButton(
                        contentColor: palette.black,
                        icon: Icons.upload_outlined,
                        title: "Export",
                        onTap: () {
                          exportFile(ExportFileType.markdown);
                        },
                      ),
                      gap12,
                      IconElevatedButton(
                        contentColor: palette.black,
                        icon: Icons.save_as_outlined,
                        title: "Save",
                        onTap: () {
                          templateDialog(context,
                              titleController: provider.titleController,
                              onTap: () => provider.saveTemplate(
                                  editorState: _editorState, context: context));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            gapW(20),
            PreviewScreen()
          ],
        ),
      ),
    );
  }

  // Load Editor
  Future<void> _loadEditor(
    Future<String> jsonStringFormat, {
    TextDirection textDirection = TextDirection.ltr,
  }) async {
    final completer = Completer<void>();
    _jsonString = jsonStringFormat;
    setState(
      () {
        _widgetBuilder = (context) => Editor(
              jsonString: _jsonString,
              onEditorStateChange: (editorState) {
                _editorState = editorState;
              },
              textDirection: textDirection,
            );
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      completer.complete();
    });
    return completer.future;
  }

  // Import File
  void importFile(ExportFileType fileType) async {
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

    if (mounted) {
      if (mounted) {
        _loadEditor(Future<String>.value(jsonString));
      }
    }
  }

  // Import Template File
  void importTemplate({required String text}) async {
    String jsonString = '';
    jsonString = jsonEncode(markdownToDocument(text).toJson());

    if (mounted) {
      if (mounted) {
        _loadEditor(Future<String>.value(jsonString));
      }
    }
  }

  // Export Files ================================================================>
  void exportFile(
    ExportFileType fileType,
  ) async {
    var result = '';

    switch (fileType) {
      case ExportFileType.documentJson:
        result = jsonEncode(_editorState.document.toJson());
        break;
      case ExportFileType.markdown:
        result = documentToMarkdown(_editorState.document);
        print(result);
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

// This is a dropdown we can change the template of the editor
  Widget templateDropdown() {
    return TemplateDropDown(
        hintText: "Templates",
        onChange: (val) {
          selectedTemplate = val;
          selctedTemplateDetails = templateList
              .firstWhere((element) => element.templateName == val)
              .template;
          Future.delayed(const Duration(milliseconds: 500), () {
            importTemplate(
              text: selctedTemplateDetails!,
            );
          });
        },
        selectedValue: selectedTemplate,
        items: templateList.map((e) => e.templateName).toList());
  }

// Add icon button it allows you to add new template to our editor
  Widget addTemplateButton({required Function onTap}) {
    return InkWell(
      onTap: onTap as void Function(),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: palette.secondary, borderRadius: BorderRadius.circular(10)),
        child: Icon(
          Icons.add,
          color: palette.white,
        ),
      ),
    );
  }
}

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

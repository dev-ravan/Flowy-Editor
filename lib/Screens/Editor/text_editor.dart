// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flowy_editor/Screens/Editor/report_editor.dart';
import 'package:flutter/material.dart';

class TextEditor extends StatefulWidget {
  const TextEditor({
    super.key,
    required this.editorState,
    required this.textDirection,
    required this.jsonString,
  });
  final EditorState editorState;
  final TextDirection textDirection;
  final Future<String> jsonString;

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  late final EditorScrollController editorScrollController;

  @override
  void initState() {
    super.initState();

    editorScrollController = EditorScrollController(
      editorState: widget.editorState,
      shrinkWrap: false,
    );
  }

  @override
  void dispose() {
    editorScrollController.dispose();
    widget.editorState.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReportEditor(
      editorState: widget.editorState,
      textDirection: widget.textDirection,
    );
  }
}

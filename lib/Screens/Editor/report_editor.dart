import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flowy_editor/Theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportEditor extends StatefulWidget {
  const ReportEditor({
    super.key,
    required this.editorState,
    required this.textDirection,
  });

  final EditorState editorState;
  final TextDirection textDirection;

  @override
  State<ReportEditor> createState() => _ReportEditorState();
}

class _ReportEditorState extends State<ReportEditor> {
  late EditorStyle editorStyle;
  late Map<String, BlockComponentBuilder> blockComponentBuilders;
  late List<CommandShortcutEvent> commandShortcuts;
  late final EditorScrollController editorScrollController;

  @override
  void initState() {
    editorScrollController = EditorScrollController(
      editorState: widget.editorState,
      shrinkWrap: false,
    );
    editorStyle = buildDesktopEditorStyle();
    blockComponentBuilders = buildBlockComponentBuilders();
    commandShortcuts = buildCommandShortcuts();
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();

    editorStyle = buildDesktopEditorStyle();
    blockComponentBuilders = buildBlockComponentBuilders();
    commandShortcuts = buildCommandShortcuts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            border: Border.all(color: palette.liteGrey),
            color: palette.white,
            borderRadius: BorderRadius.circular(10)),
        child: FloatingToolbar(
          items: [
            paragraphItem,
            ...headingItems,
            ...markdownFormatItems,
            quoteItem,
            bulletedListItem,
            numberedListItem,
            linkItem,
            buildTextColorItem(),
            buildHighlightColorItem(),
            ...textDirectionItems,
            ...alignmentItems,
          ],
          editorState: widget.editorState,
          textDirection: widget.textDirection,
          editorScrollController: editorScrollController,
          child: AppFlowyEditor(
            editorState: widget.editorState,
            editorScrollController: editorScrollController,
            blockComponentBuilders: buildBlockComponentBuilders(),
            commandShortcutEvents: buildCommandShortcuts(),
            editorStyle: buildDesktopEditorStyle(),
          ),
        ));
  }

  // showcase 1: customize the editor style.
  EditorStyle buildDesktopEditorStyle() {
    return EditorStyle.desktop(
      cursorWidth: 2.0,
      cursorColor: palette.primary,
      selectionColor: palette.secondaryGrey,
      textStyleConfiguration: TextStyleConfiguration(
        text: GoogleFonts.dmSans(
          fontSize: 16,
          color: palette.black,
        ),
        code: GoogleFonts.architectsDaughter(),
        bold: GoogleFonts.dmSans(
          fontWeight: FontWeight.w500,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
    );
  }

  // showcase 2: customize the block style
  Map<String, BlockComponentBuilder> buildBlockComponentBuilders() {
    final map = {
      ...standardBlockComponentBuilderMap,
    };
    // customize the image block component to show a menu
    map[ImageBlockKeys.type] = ImageBlockComponentBuilder(
      showMenu: true,
      menuBuilder: (node, _) {
        return const Positioned(
          right: 10,
          child: Text('⭐️ Here is a menu!'),
        );
      },
    );
    // customize the heading block component
    final levelToFontSize = [
      30.0,
      26.0,
      22.0,
      18.0,
      16.0,
      14.0,
    ];
    map[HeadingBlockKeys.type] = HeadingBlockComponentBuilder(
      textStyleBuilder: (level) => GoogleFonts.poppins(
        fontSize: levelToFontSize.elementAtOrNull(level - 1) ?? 14.0,
        fontWeight: FontWeight.w600,
      ),
    );
    // customize the padding
    map.forEach((key, value) {
      value.configuration = value.configuration.copyWith(
        padding: (_) => const EdgeInsets.symmetric(vertical: 8.0),
      );
    });
    return map;
  }

  // showcase 3: customize the command shortcuts
  List<CommandShortcutEvent> buildCommandShortcuts() {
    return [
      // customize the highlight color
      customToggleHighlightCommand(
        style: ToggleColorsStyle(
          highlightColor: Colors.orange.shade700,
        ),
      ),
      ...[
        ...standardCommandShortcutEvents
          ..removeWhere(
            (el) => el == toggleHighlightCommand,
          ),
      ],
      ...findAndReplaceCommands(
        context: context,
        localizations: FindReplaceLocalizations(
          find: 'Find',
          previousMatch: 'Previous match',
          nextMatch: 'Next match',
          close: 'Close',
          replace: 'Replace',
          replaceAll: 'Replace all',
          noResult: 'No result',
        ),
      ),
    ];
  }
}

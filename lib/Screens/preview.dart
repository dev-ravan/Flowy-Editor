import 'package:flowy_editor/Screens/junk.dart';
import 'package:flowy_editor/Theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JunkProvider>();
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
          border: Border.all(color: palette.liteGrey),
          color: palette.white,
          borderRadius: BorderRadius.circular(10)),
      child: Markdown(
        data: provider.templateMarkdown ?? "",
        onTapLink: (text, href, title) {
          // Handle link taps
          print('Tapped link: $href');
        },
      ),
    );
  }
}

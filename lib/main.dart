import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flowy_editor/Screens/home.dart';
import 'package:flowy_editor/Screens/junk.dart';
import 'package:flowy_editor/Theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<JunkProvider>(
            create: (context) => JunkProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          AppFlowyEditorLocalizations.delegate,
        ],
        supportedLocales: AppFlowyEditorLocalizations.delegate.supportedLocales,
        title: 'Flowy Editor',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: palette.secondary),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

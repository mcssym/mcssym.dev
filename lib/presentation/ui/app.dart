import 'package:flutter/material.dart';

import 'screens/pages/home/home.view.dart';
import 'theming/editorial_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maxime Fankam — Software Engineer',
      theme: EditorialTheme.light(),
      darkTheme: EditorialTheme.dark(),
      themeMode: ThemeMode.system,
      home: const HomeView(),
    );
  }
}

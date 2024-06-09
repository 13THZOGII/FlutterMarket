import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/storage.dart';

class LoaderScreen extends StatefulWidget {
  const LoaderScreen({Key? key}) : super(key: key);

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  loadApp() async {
    final storage = Storage();
    final FirstLaunch = await storage.isFirstLaunch();
    if (FirstLaunch) {
      const DarkMode = ThemeMode.system == ThemeMode.dark;

      await storage.setConfig(
          language: getDeviceLanguage(), darkMode: DarkMode);

      GoRouter.of(context).replace("/splash");
    } else {
      final config = await storage.getConfig();
      if (config["language"] == null) {
        storage.setConfig(language: getDeviceLanguage());
      }
      if (config["DarkMode"] == null) {
        const DarkMode = ThemeMode.system == ThemeMode.dark;
        await storage.setConfig(darkMode: DarkMode);
      }
      GoRouter.of(context).replace("/home");
    }
  }

  getDeviceLanguage() {
    final String defaultLocale;
    if (!kIsWeb) {
      defaultLocale = Platform.localeName;
    } else {
      defaultLocale = "en";
    }

    final langParts = defaultLocale.split("_");
    final supportedLanguages = ["en", "tr"];
    final String FinalLang;
    if (supportedLanguages.contains(langParts[0])) {
      FinalLang = langParts[0];
    } else {
      FinalLang = "en";
    }
    return FinalLang;
  }

  @override
  void initState() {
    super.initState();
    loadApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

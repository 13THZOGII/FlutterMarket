import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../core/localizations.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.phone, "label": "Telefon", "route": "/telephone"},
    {"icon": Icons.camera_alt, "label": "Fotoğraf M", "route": "/camera"},
    {"icon": Icons.computer, "label": "Bilgisayar", "route": "/computer"},
    {"icon": Icons.monitor_sharp, "label": "Monitör", "route": "/monitor"},
    {"icon": Icons.games_sharp, "label": "konsol", "route": "/gamepad"},
    {"icon": Icons.mouse, "label": "Fare", "route": "/mouse"},
    {"icon": Icons.headset, "label": "Kulaklık", "route": "/kulaklik"},
    {
      "icon": Icons.laptop_chromebook_rounded,
      "label": "Leptop",
      "route": "/leptop"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).getTranslate("categories")),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Text(
                    AppLocalizations.of(context).getTranslate("categories"),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: categories.length ~/ 2,
                          itemBuilder: (context, index) {
                            return buildCategoryButton(
                              context: context,
                              icon: categories[index]['icon'],
                              label: getTranslatedLabel(
                                  context, categories[index]['label']),
                              onTap: () {
                                GoRouter.of(context)
                                    .push(categories[index]['route']);
                              },
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: categories.length ~/ 2,
                          itemBuilder: (context, index) {
                            final offset = categories.length ~/ 2;
                            return buildCategoryButton(
                              context: context,
                              icon: categories[index + offset]['icon'],
                              label: getTranslatedLabel(
                                  context, categories[index + offset]['label']),
                              onTap: () {
                                GoRouter.of(context)
                                    .push(categories[index + offset]['route']);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCategoryButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required void Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: Theme.of(context).iconTheme.color,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black, // Varsayılan metin rengi
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTranslatedLabel(BuildContext context, String label) {
    return AppLocalizations.of(context).getTranslate(label);
  }

  String getTranslatedLabelKonsol(BuildContext context) {
    return "konsol";
  }

  String getTranslatedLabelFare(BuildContext context) {
    return "Fare";
  }

  String getTranslatedLabelKulakl(BuildContext context) {
    return "Kulaklık";
  }

  String getTranslatedLabelLeptop(BuildContext context) {
    return "Leptop";
  }
}

void main() {
  runApp(CategoriesScreen());
}

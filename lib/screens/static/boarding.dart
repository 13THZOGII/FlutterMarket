import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:preload_page_view/preload_page_view.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _BoardingPage();
  }
}

class _BoardingPage extends StatefulWidget {
  const _BoardingPage({Key? key}) : super(key: key);

  @override
  _BoardingPageState createState() => _BoardingPageState();
}

class _BoardingPageState extends State<_BoardingPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final boardingData = [
      {
        "image": "assets/images/OIG4.jpg",
        "title": "Ne Alırsan Al !",
        "description": "E Ticaret Uygulaması",
      },
      {
        "image": "assets/images/resim.jpg",
        "title": "Ne Alırsan Al !",
        "description": "E Ticaret Uygulaması",
      },
      {
        "image": "assets/images/resim.jpg",
        "title": "Ne Alırsan Al !",
        "description": "E Ticaret Uygulaması",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 35.0),
            child: InkWell(
              onTap: () {
                GoRouter.of(context).go('/login');
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: currentPage == boardingData.length - 1
                    ? const Text("BİTTİ")
                    : const Text("ATLA"),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: PreloadPageView.builder(
          itemCount: boardingData.length,
          preloadPagesCount: boardingData.length,
          onPageChanged: (value) {
            setState(() {
              currentPage = value;
            });
          },
          itemBuilder: (context, index) => _BoardingItem(
            image: boardingData[index]["image"]!,
            title: boardingData[index]["title"]!,
            description: boardingData[index]["description"]!,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Align(
          alignment: Alignment.center,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: boardingData.length,
            itemBuilder: (context, index) => Icon(
              index == currentPage ? Icons.circle : Icons.circle_outlined,
            ),
          ),
        ),
      ),
    );
  }
}

class _BoardingItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const _BoardingItem({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(38.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.network(image),
              Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(description),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

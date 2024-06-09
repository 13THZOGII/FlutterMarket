import 'package:flutter/material.dart';

class BoardingItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const BoardingItem({
    Key? key, // burada key doğru şekilde tanımlanmalı
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

import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget {
  final String imagePath;

  const DemoPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading image: $error');
          return Center(child: Text('Error loading image'));
        },
      ),
    );
  }
}

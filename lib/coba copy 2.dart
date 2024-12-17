import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_flip/page_flip.dart';

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

class Coba extends StatefulWidget {
  const Coba({Key? key}) : super(key: key);

  @override
  State<Coba> createState() => _CobaState();
}

class _CobaState extends State<Coba> {
  final _controllerSingle = GlobalKey<PageFlipWidgetState>();
  final _controllerDouble = GlobalKey<PageFlipWidgetState>();

  List<String> imagePaths = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadImagePaths();
  }

  Future<void> loadImagePaths() async {
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      final loadedImagePaths = manifestMap.keys
          .where((String key) => key.contains('assets/'))
          .where((String key) => key.contains('.jpg') || key.contains('.png'))
          .toList();

      loadedImagePaths.sort(); // Sort the paths to ensure consistent order

      setState(() {
        imagePaths = loadedImagePaths;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading image paths: $e');
      setState(() {
        errorMessage = 'Failed to load images. Please try again.';
        isLoading = false;
      });
    }
  }

  Widget buildPageFlipWidget(Orientation orientation) {
    if (imagePaths.isEmpty) {
      return Center(child: Text(errorMessage ?? 'No images found.'));
    }

    final isPortrait = orientation == Orientation.portrait;
    final controller = isPortrait ? _controllerSingle : _controllerDouble;

    return PageFlipWidget(
      key: controller,
      backgroundColor: Colors.white,
      lastPage: Container(
        color: Colors.white,
        child: const Center(child: Text('Last Page!')),
      ),
      children: <Widget>[
        if (isPortrait)
          for (var imagePath in imagePaths) DemoPage(imagePath: imagePath)
        else
          for (var i = 0; i < imagePaths.length; i += 2)
            Row(
              children: [
                Expanded(child: DemoPage(imagePath: imagePaths[i])),
                if (i + 1 < imagePaths.length)
                  Expanded(child: DemoPage(imagePath: imagePaths[i + 1]))
                else
                  Expanded(child: Container(color: Colors.white)),
              ],
            ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : OrientationBuilder(
              builder: (context, orientation) {
                return buildPageFlipWidget(orientation);
              },
            ),
      floatingActionButton: OrientationBuilder(
        builder: (context, orientation) {
          return FloatingActionButton(
            child: const Icon(Icons.looks_5_outlined),
            onPressed: () {
              final pageToGo = orientation == Orientation.portrait ? 4 : 2;
              final controller = orientation == Orientation.portrait
                  ? _controllerSingle
                  : _controllerDouble;
              controller.currentState?.goToPage(pageToGo);
            },
          );
        },
      ),
    );
  }
}

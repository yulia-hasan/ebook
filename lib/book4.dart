import 'dart:convert';
import 'DemoPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_flip/page_flip.dart';


class Book4 extends StatefulWidget {
  const Book4({Key? key}) : super(key: key);

  @override
  State<Book4> createState() => _Book4State();
}

class _Book4State extends State<Book4> {
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

  // ... (loadImagePaths method remains the same)
  Future<void> loadImagePaths() async {
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      print(manifestMap);
      print('All manifest keys: ${manifestMap.keys}');

      final loadedImagePaths = manifestMap.keys
          .where((String key) => key.contains('images/pertemuan4/'))
          .where((String key) => key.contains('.jpg') || key.contains('.png'))
          .toList();

      // Sort numerically based on the number in the file name
      loadedImagePaths.sort((a, b) {
        final regExp =
            RegExp(r'modul_Page(\d+)\.'); // Matches "modul_Page<num>."
        final matchA = regExp.firstMatch(a);
        final matchB = regExp.firstMatch(b);

        if (matchA != null && matchB != null) {
          final numA = int.parse(matchA.group(1)!); // Extract the number from a
          final numB = int.parse(matchB.group(1)!); // Extract the number from b
          return numA.compareTo(numB); // Compare numerically
        }

        return a.compareTo(b); // Fallback to string comparison if no number
      });

      // Debug: Print image paths
      print('Loaded image paths: $loadedImagePaths');

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(child: DemoPage(imagePath: imagePaths[i])),
                if (i + 1 < imagePaths.length)
                  Flexible(child: DemoPage(imagePath: imagePaths[i + 1]))
                else
                  Flexible(child: Container(color: Colors.white)),
              ],
            ),
      ],
      // Animation settings
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Modul"),
      ),
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

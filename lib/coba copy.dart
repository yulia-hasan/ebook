import 'package:ebook/DemoPage.dart';
import 'package:flutter/material.dart';
import 'package:ebook/TwoPageinOne.dart';
import 'package:page_flip/page_flip.dart';

class DemoPage extends StatelessWidget {
  final int page;

  const DemoPage({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('Page $page'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            // Single page for portrait mode
            return PageFlipWidget(
              key: _controllerSingle,
              backgroundColor: Colors.white,
              lastPage: Container(
                color: Colors.white,
                child: const Center(child: Text('Last Page!')),
              ),
              children: <Widget>[
                for (var i = 0; i < 10; i++) DemoPage(page: i),
              ],
            );
          } else {
            // Two pages for landscape mode
            return PageFlipWidget(
              key: _controllerDouble,
              backgroundColor: Colors.white,
              lastPage: Container(
                color: Colors.white,
                child: const Center(child: Text('Last Page!')),
              ),
              children: <Widget>[
                for (var i = 0; i < 10; i += 2)
                  Row(
                    children: [
                      Expanded(child: DemoPage(page: i)),
                      if (i + 1 < 10) Expanded(child: DemoPage(page: i + 1)),
                    ],
                  ),
              ],
            );
          }
        },
      ),
      floatingActionButton: OrientationBuilder(
        builder: (context, orientation) {
          return FloatingActionButton(
            child: const Icon(Icons.looks_5_outlined),
            onPressed: () {
              if (orientation == Orientation.portrait) {
                _controllerSingle.currentState?.goToPage(5);
              } else {
                _controllerDouble.currentState
                    ?.goToPage(2); // Goes to pages 4-5 in landscape
              }
            },
          );
        },
      ),
    );
  }
}

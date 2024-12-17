import 'package:flutter/material.dart';

class TwoPagesInOne extends StatelessWidget {
  const TwoPagesInOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Two Pages in One'),
      ),
      body: Row(
        children: [
          Expanded(
            child: PageContent(pageNumber: 1, color: Colors.blue[100]!),
          ),
          Container(
            width: 2,
            color: Colors.black,
          ),
          Expanded(
            child: PageContent(pageNumber: 2, color: Colors.green[100]!),
          ),
        ],
      ),
    );
  }
}

class PageContent extends StatelessWidget {
  final int pageNumber;
  final Color color;

  const PageContent({
    Key? key,
    required this.pageNumber,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Page $pageNumber',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality for the button if needed
              },
              child: Text('Button on Page $pageNumber'),
            ),
          ],
        ),
      ),
    );
  }
}

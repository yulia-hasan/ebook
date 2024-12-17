import 'book4.dart';
import 'package:ebook/coba.dart';
import 'package:ebook/book3.dart';
import 'package:ebook/book2.dart';
import 'package:ebook/book1.dart';
import 'package:flutter/material.dart';

class EbookListScreen extends StatelessWidget {
  final List<Map<String, String>> ebooks = [
    // {
    //   'title': 'Pertemuan 1',
    //   'author': 'Yulia Hasan, S.Pd',
    //   'image': 'assets/images/pertemuan1/1.png'
    // },
    // {
    //   'title': 'Pertemuan 2',
    //   'author': 'Yulia Hasan, S.Pd',
    //   'image': 'assets/images/pertemuan2/1.png'
    // },
    // {
    //   'title': 'Pertemuan 3',
    //   'author': 'Yulia Hasan, S.Pd',
    //   'image': 'assets/images/pertemuan3/1.png'
    // },
    {
      'title': 'E-Modul',
      'author': 'Yulia Hasan, S.Pd',
      'image': 'images/pertemuan4/modul_Page1.png'
    },
    // {'title': 'Ebook 4', 'author': 'Author 4', 'image': 'assets/images/4.png'},
    // {'title': 'Ebook 5', 'author': 'Author 5', 'image': 'assets/images/5.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ebook List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Membuat 2 kolom
            childAspectRatio: 0.7, // Mengatur rasio aspek card
            crossAxisSpacing: 10, // Jarak antar kolom
            mainAxisSpacing: 10, // Jarak antar baris
          ),
          itemCount: ebooks.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (ebooks[index]['title'] == 'Pertemuan 1') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Book1()),
                  );
                } else if (ebooks[index]['title'] == 'Pertemuan 2') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Book2(),
                      ));
                } else if (ebooks[index]['title'] == 'Pertemuan 3') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Book3(),
                      ));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Book4(),
                      ));
                }
              },
              child: EbookCard(
                title: ebooks[index]['title']!,
                author: ebooks[index]['author']!,
                image: ebooks[index]['image']!,
              ),
            );
          },
        ),
      ),
    );
  }
}

class EbookCard extends StatelessWidget {
  final String title;
  final String author;
  final String image;

  const EbookCard({
    Key? key,
    required this.title,
    required this.author,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              author,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10), // Padding bawah
        ],
      ),
    );
  }
}

class EbookDetailScreen extends StatelessWidget {
  final String title;
  final String author;
  final String image;

  const EbookDetailScreen({
    Key? key,
    required this.title,
    required this.author,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(image),
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Author: $author',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

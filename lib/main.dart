import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'data.dart';
import 'shrine/app.dart';
import 'babynames/app.dart';

void main() {
//  debugPaintSizeEnabled = true;
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Flutter Practice';
    return MaterialApp(
      title: title,
      routes: {
        '/': (context) => MainHomePage(title),
        '/babynames': (context) => BabyNamesPage(),
        '/shrine': (context) => ShrinePage()
      },
      initialRoute: '/',
    );
  }
}

class MainHomePage extends StatelessWidget {
  final List<Practice> practices = Practice.createList();
  final String title;

  MainHomePage(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          backgroundColor: Colors.grey[300],
          body: ListView.builder(
              itemCount: practices.length,
              itemBuilder: (context, index) {
                return MainListItem(practices[index]);
              }
          )
      )
    );
  }
}

class MainListItem extends StatelessWidget {
  final Practice practice;

  MainListItem(this.practice);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 0.0, top: 12.0),
      child: InkWell(
        child: Container(
          child: Text(
            practice.title,
            style: Theme.of(context).textTheme.title
          ),
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
        ),
        onTap: () {
          Navigator.pushNamed(context, practice.route);
        },
      ),
    );
  }
}

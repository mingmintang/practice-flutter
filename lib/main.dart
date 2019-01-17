import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'shrine/app.dart';

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
      home: MainHomePage(title),
    );
  }
}

class MainHomePage extends StatelessWidget {
  final String title;

  MainHomePage(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        backgroundColor: Colors.grey[300],
        body: Column(
          children: <Widget>[ShrineButton()],
        ));
  }
}

class ShrineButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin:
            EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0, top: 18.0),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ShrineApp()));
          },
          child: Container(
            constraints: BoxConstraints(minWidth: double.infinity),
            padding: EdgeInsets.all(12.0),
            alignment: Alignment.center,
            child: Text(
              'Shrine',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ));
  }
}

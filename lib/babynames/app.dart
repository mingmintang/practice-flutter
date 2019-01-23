import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BabyNamesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BabyNamesPage();
  }
}

class _BabyNamesPage extends State<BabyNamesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Baby Name Votes')),
      body: StreamBuilder(
        stream: Firestore.instance.collection('baby').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(snapshot.data.documents);
        }
      )
    );
  }

  Widget _buildList(List<DocumentSnapshot> snapshots) {
    return ListView(
      children: snapshots.map((document) {
        final record = Record.fromSnapshot(document);
        return _buildListItem(record);
      }).toList()
    );
  }

  Widget _buildListItem(Record record) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Container(
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.votes.toString()),
          onTap: () => _plusVote(record),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15.0)
        ),
      ),
    );
  }
}

void _plusVote(Record record) {
  Firestore.instance.runTransaction((transaction) async {
    final snapshot = await transaction.get(record.reference);
    final votes = Record.fromSnapshot(snapshot).votes;
    await transaction.update(record.reference, {'votes': votes + 1});
  });
}

final dummySnapshot = [
  {"name": "Filip", "votes": 12},
  {"name": "Mac", "votes": 13},
  {"name": "Justin", "votes": 2},
  {"name": "Richard", "votes": 22},
  {"name": "Ikea", "votes": 5},
];

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() {
    return "Record<$name: $votes>";
  }
}
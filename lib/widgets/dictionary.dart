import 'package:flutter/material.dart';
import '../utils/database_helper.dart';

class DictionaryWidget extends StatefulWidget {
  @override
  _DictionaryWidgetState createState() => _DictionaryWidgetState();
}

class _DictionaryWidgetState extends State<DictionaryWidget> {
  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> words = [];

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  _loadWords() async {
    final allWords = await dbHelper.queryAll();
    setState(() {
      words = allWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: words.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(words[index]['chinese']),
          subtitle:
              Text('${words[index]['pinyin']} - ${words[index]['russian']}'),
        );
      },
    );
  }
}

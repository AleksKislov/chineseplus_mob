import 'package:flutter/material.dart';
// import 'dart:convert';

class DictWordDetailsScreen extends StatelessWidget {
  final String russianText;
  final String chineseText;

  DictWordDetailsScreen({required this.russianText, required this.chineseText});

  @override
  Widget build(BuildContext context) {
    String parsedText = parseBBCode(russianText);

    return Scaffold(
      appBar: AppBar(title: Text(chineseText)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Text(parsedText),
      ),
    );
  }
}

String parseBBCode(String input) {
  List<String> stack = [];
  StringBuffer output = StringBuffer();
  StringBuffer currentLine = StringBuffer();

  for (int i = 0; i < input.length; i++) {
    if (input[i] == '[') {
      int endIndex = input.indexOf(']', i);
      if (endIndex != -1) {
        String tag = input.substring(i + 1, endIndex);
        if (tag.startsWith('/')) {
          // Closing tag
          String openTag = stack.removeLast();
          currentLine.write(input.substring(i, endIndex + 1));
          if (stack.isEmpty) {
            output.writeln(currentLine.toString());
            currentLine.clear();
          }
        } else {
          // Opening tag
          stack.add(tag);
          currentLine.write(input.substring(i, endIndex + 1));
        }
        i = endIndex;
      }
    } else {
      currentLine.write(input[i]);
    }
  }

  if (currentLine.isNotEmpty) {
    output.write(currentLine.toString());
  }

  return output.toString();
}

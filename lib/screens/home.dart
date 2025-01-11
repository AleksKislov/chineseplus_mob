import 'package:flutter/material.dart';
import 'package:mobile/widgets/search_results.dart';
import '../utils/database_helper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Китайско-русский словарь'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DictionarySearch(),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Use the search icon to look up Chinese words'),
      ),
    );
  }
}

class DictionarySearch extends SearchDelegate<String> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResultsWidget(query: query, databaseHelper: _databaseHelper);

    // return FutureBuilder<List<Map<String, dynamic>>>(
    //   future: _databaseHelper.searchChinese(query),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     } else if (snapshot.hasError) {
    //       return Center(child: Text('Error: ${snapshot.error}'));
    //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //       return Center(child: Text('No results found'));
    //     } else {
    //       return ListView.builder(
    //         itemCount: snapshot.data!.length,
    //         itemBuilder: (context, index) {
    //           var entry = snapshot.data![index];
    //           return Card(
    //             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    //             child: Padding(
    //               padding: EdgeInsets.all(16),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     entry['chinese'],
    //                     style: TextStyle(
    //                       fontSize: 24,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                   SizedBox(height: 4),
    //                   Text(
    //                     entry['pinyin'],
    //                     style: TextStyle(
    //                       fontSize: 16,
    //                       color: Colors.green,
    //                     ),
    //                   ),
    //                   SizedBox(height: 4),
    //                   Text(
    //                     entry['russian'],
    //                     style: TextStyle(
    //                       fontSize: 18,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           );
    //         },
    //       );
    //     }
    //   },
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text('Type to search for Chinese words'));
  }
}

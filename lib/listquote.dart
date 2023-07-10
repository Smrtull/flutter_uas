import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListQuote extends StatelessWidget {
  final String apiUrl = "https://indonesia-public-static-api.vercel.app/api/heroes";

  const ListQuote({super.key});

  Future<List<dynamic>> _fetchListQuotes() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('pahlawan indonesia'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchListQuotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      snapshot.data[index]['name'],
                      textAlign: TextAlign.justify,
                    ),
                    subtitle: Text(
                      // ignore: prefer_interpolation_to_compose_strings
                      "\nJasa : " + snapshot.data[index]['description'],
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    trailing: Text(snapshot.data[index]['ascension_year'].toString()),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

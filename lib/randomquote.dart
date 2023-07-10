import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'listquote.dart';
import 'dart:convert';

class RandomQuote extends StatelessWidget {
  final String apiUrl = "https://quote-api.dicoding.dev/random";

  const RandomQuote({super.key});

  Future<dynamic> _fecthRandomQuotes() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Quotes'),
      ),
      body: FutureBuilder<dynamic>(
        future: _fecthRandomQuotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          snapshot.data['en'],
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        // ignore: prefer_interpolation_to_compose_strings
                        Text(
                          // ignore: prefer_interpolation_to_compose_strings
                          "~ " + snapshot.data['author'],
                          style: const TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 110,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ListQuote(),
                              ),
                            );
                          },
                          child: const Text('List Quote',
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
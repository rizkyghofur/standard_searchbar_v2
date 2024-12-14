import 'package:flutter/material.dart';
import 'package:standard_searchbar/new/standard_search_anchor.dart';
import 'package:standard_searchbar/new/standard_search_bar.dart';
import 'package:standard_searchbar/new/standard_suggestion.dart';
import 'package:standard_searchbar/new/standard_suggestions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Standard SearchBar Example'),
        ),
        body: const SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 100),
              SizedBox(
                width: 360,
                child: StandardSearchAnchor(
                  searchBar: StandardSearchBar(
                    bgColor: Colors.red,
                  ),
                  suggestions: StandardSuggestions(
                    suggestions: [
                      StandardSuggestion(text: 'Suggestion 1'),
                      StandardSuggestion(text: 'Suggestion 2'),
                      StandardSuggestion(text: 'Suggestion 3'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // backgroundColor: Colors.black12,
        backgroundColor: const Color(0xFF12202F),
      ),
    );
  }
}

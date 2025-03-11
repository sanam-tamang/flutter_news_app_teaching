import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categories = [
    "Business",
    "Computer",
    "Stock",
    "Health",
    "Science",
    "Sports",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length, //6
      child: Scaffold(
        appBar: AppBar(
          title: Text("News app"),

          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs:
                categories.map((category) {
                  return Tab(child: Text(category));
                }).toList(),
          ),
        ),

        body: TabBarView(
          children: categories.map((category) => Text(" $category")).toList(),
        ),
      ),
    );
  }
}

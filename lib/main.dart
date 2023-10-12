import 'package:flutter/material.dart';
import 'package:minggu_04/http.helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Movie App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String result;
  late HttpHelper helper;
  String selectedCategory = 'latest';

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    result = '';
    fetchData(selectedCategory);
  }

  void fetchData(String category) {
    helper.getMovie(category).then((value) {
      setState(() {
        result = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedCategory,
            items: <String>[
              'latest',
              'now_playing',
              'popular',
              'top_rated',
              'upcoming',
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedCategory = newValue;
                });
                fetchData(selectedCategory);
              }
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(result),
            ),
          ),
        ],
      ),
    );
  }
}

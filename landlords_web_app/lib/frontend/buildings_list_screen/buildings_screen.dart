import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BuildingsScreen extends StatefulWidget {
  const BuildingsScreen({super.key});

  @override
  BuildingsScreenState createState() => BuildingsScreenState();
}

class BuildingsScreenState extends State<BuildingsScreen> {
  List<String> buildings = [
    'Building 1',
    'Building 2',
    'Building 3',
    'Building 4',
    'Building 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buildings List'),
      ),
      body: Column(
        children: [
          // ListView.builder(
          //   itemCount: buildings.length,
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Text(buildings[index]),
          //       onTap: () {
          //         // Handle building tap
          //       },
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

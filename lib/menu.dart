import 'package:flutter/material.dart';
import 'package:my_project_name/games.dart';
import 'package:my_project_name/games2.dart';
import 'package:my_project_name/stores.dart';

class MyMenu extends StatefulWidget {
  @override
  _MyMenuState createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  int index = 0;
  List<Widget> _widgets = [screen1(), screen2(), screen3()];
  tapped(int tappedIndex) {
    setState(() {
      index = tappedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _widgets[index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: tapped,
          items: [
            BottomNavigationBarItem(
                icon: new Icon(Icons.looks_one), title: Text('One')),
            BottomNavigationBarItem(
                icon: new Icon(Icons.looks_two), title: Text('Two')),
            BottomNavigationBarItem(
                icon: new Icon(Icons.looks_3), title: Text('Three')),
          ],
        ),
      ),
    );
  }
}

screen1() {
  return Center(
    child: Stores(),
  );
}

screen2() {
  return Center(
    child: Games(),
  );
}

screen3() {
  return Center(
    child: Games2(),
  );
}

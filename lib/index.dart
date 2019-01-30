import 'package:flutter/material.dart';
import 'package:youxia/pages/newsPage.dart';
import 'package:youxia/pages/user/index.dart';

class MyApp extends StatefulWidget {

  // This widget is the root of your application.


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [NewsPage(), UserPage()];

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar:
        BottomNavigationBar(
            onTap: (index){
              setState(() {
                _currentIndex = index;
              });
            },
            currentIndex: _currentIndex, items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Container(
                height: 0,
              )),
          new BottomNavigationBarItem(
              icon: Icon(Icons.headset),
              title: Container(
                height: 0,
              ))
        ]),
      ),
    );
  }

}

void main() => runApp(MyApp());

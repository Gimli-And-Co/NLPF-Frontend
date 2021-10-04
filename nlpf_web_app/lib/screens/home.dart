import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

int bottomSelectedIndex = 0;

List<BottomNavigationBarItem> buildBottomNavBarItems() {
  return [
    BottomNavigationBarItem(
        icon: new Icon(Icons.home),
        title: new Text('home')
    ),
    BottomNavigationBarItem(
      icon: new Icon(Icons.search),
      title: new Text('layout'),
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.info),
        title: Text('profile')
    )
  ];
}

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal, ),
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: bottomSelectedIndex,
      items: buildBottomNavBarItems(),
      ),
      body: Center(
        child: FlatButton(
          color: Colors.teal,
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
          child: Text('Home'),
        ),
      ),
    );
  }
}

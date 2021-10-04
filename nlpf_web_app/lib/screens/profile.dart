import 'package:flutter/material.dart';

import 'layout.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
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

class _ProfileState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent),
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: bottomSelectedIndex,
      items: buildBottomNavBarItems(),
      ),
      body: Center(
        child: FlatButton(
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed((context), '/');
          },
          child: Text('Profile'),
        ),
      ),
    );
  }
}

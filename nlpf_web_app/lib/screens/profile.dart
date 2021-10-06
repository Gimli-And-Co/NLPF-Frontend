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
      currentIndex: 2,
      items: buildBottomNavBarItems(),
      onTap: (index) {
      switch (index) {
        case 0:
          setState(() {
             Navigator.pushNamed(context, '/');
          });
          break;
          case 1:
          setState(() {
             Navigator.pushNamed(context, '/home');
          });
          break;
          case 2:
          setState(() {
             Navigator.pushNamed(context, '/profile');
          });
          break;
        default:
        { print("Invalid choice"); } 
        break; 
      };
      },
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

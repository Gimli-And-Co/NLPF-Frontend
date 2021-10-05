import 'package:flutter/material.dart';

class DevScreen extends StatefulWidget {
  @override
  _DevState createState() => _DevState();
}

class _DevState extends State<DevScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal, ),
      body: Center(
        child: FlatButton(
          color: Colors.teal,
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
          child: Text('Profile'),
        ),
      ),
    );
  }
}

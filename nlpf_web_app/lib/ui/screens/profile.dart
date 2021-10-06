import 'package:flutter/material.dart';

import 'layout.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent),
      body:  Padding(  
            padding: EdgeInsets.all(15),  
            child: Column(  
              children: <Widget>[  
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Name',  
                      hintText: 'Enter Your Name',  
                    ),  
                  ),  
                ),  

                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Firstname',  
                      hintText: 'Enter Your Firstname',  
                    ),  
                  ),  
                ),  
      
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Offre 1',  
                      hintText: 'Entrer la ville de votre première offre',  
                    ),  
                  ),  
                ),  
      

                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Offre 2',  
                      hintText: 'Entrer la ville de votre deuxième offre',  
                    ),  
                  ),  
                ),
                
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Offre 3',  
                      hintText: 'Entrer le ville de votre troisième offre',  
                    ),  
                  ),  
                ),  

                Center(
                  child: FlatButton(
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed((context), '/');
                    },
                    child: Text('Profile'),
                  ),
                )
              ]
            )
      )
    );
  }
}

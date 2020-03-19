import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.brown[600],
          title: Text("I Am Poor"),
        ),
        body: Center(child: Image(image: AssetImage('./assets/iampoor.jpg'))),
      ),
    ));

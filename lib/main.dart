import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String headerText="";
  String footerText="";

  File _image;
  File _imageFile;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            Center(
              child: Image.asset(
                "assets/homelogo.png",
                height: 150,
                width: 150,
              ),
            ),
            SizedBox(height: 12,),
            Text(
              "MEME",
              style: TextStyle(
                color: Colors.red,
                fontSize: 30,
                fontWeight: FontWeight.w900
              ),
            ),
            Text(
              "GENERATOR",
              style: TextStyle(
                color: Colors.red,
                fontSize: 30,
                fontWeight: FontWeight.w900
              ),
            ),
            Stack(
              children: <Widget>[
                _image != null 
                ? Image.file(
                  _image,
                  height: 300,
                ) 
                : Container(),
              // Container(
              //   padding: EdgeInsets.symmetric(vertical:12),
              //   child: Column(
              //     children: <Widget>[
              //       Text(headerText),
              //       Spacer(),
              //       Text(footerText),                     
              //     ],
              //   ),
              // ),
              ],
            ),
            SizedBox(height: 20,),
            TextField(
              onChanged: (val){
                headerText=val;
              },
              decoration: InputDecoration(
                helperText: "Header Text",
              ),
            ),
            SizedBox(height: 12,),
            TextField(
              onChanged: (val){
                headerText=val;
              },
              decoration: InputDecoration(
                helperText: "Footer Text",
              ),
            ),
            RaisedButton(
              onPressed: (){
                takeScreenshot();
              },
              child: Text(
                "Save",
              ),
            ),
          ],
        ),
      ),
    );
  }

  takeScreenshot(){

  }
}

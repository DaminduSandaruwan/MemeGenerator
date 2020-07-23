import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

  final GlobalKey globalKey = new GlobalKey();

  String headerText="";
  String footerText="";

  File _image;
  File _imageFile;

  bool imageSelected = false;

  Random rng = new Random();

  Future getImage() async{
    var image;
    try{
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    catch(platformException){
      print("not allowing"+platformException);
    }
    setState(() {
      if(image != null){
        imageSelected = true;
      }
      else{

      }
      _image=image;
    });
  }
 
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
            RepaintBoundary(
              key: globalKey,
              child: Stack(
                children: <Widget>[
                  _image != null 
                  ? Image.file(
                    _image,
                    height: 300,
                  ) 
                  : Container(),
                Container(
                  padding: EdgeInsets.symmetric(vertical:12),
                  child: Column(
                    children: <Widget>[
                      Text(headerText),
                      Spacer(),
                      Text(footerText),                     
                    ],
                  ),
                ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            imageSelected ? Column(
              children: <Widget>[
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
            ) 
            : Container(

            ),
          ],
        ),
      ),
    );
  }

  takeScreenshot()async{
    RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    File imgFile = new File('$directory/screenshot${rng.nextInt(200)}.png');
    setState(() {
      _imageFile = imgFile;
    });
    _savefile(_imageFile);
    imgFile.writeAsBytes(pngBytes);
  }

  _savefile(File file)async{
    await _askPermission();
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(await file.readAsBytes())
    );
    print(result);
  }

  _askPermission()async{
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.photos]);
  }
}

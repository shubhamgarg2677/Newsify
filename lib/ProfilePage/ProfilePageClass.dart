import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
  
}

class ProfilePageState extends State<ProfilePage>
{
  var _imageprofile,_nameprofile;
  TextEditingController controller=new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _checkPreferences();
    super.initState();
  }

  _checkPreferences() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("User_name"))
    {
      _nameprofile=prefs.getString("User_name");
      controller.text=_nameprofile;
    }
    if(prefs.containsKey("User_image"))
    {
      print(prefs.getString("User_image"));
      setState(() {
        //_imageprofile=File(prefs.getString("User_image"));
        _imageprofile = base64Decode(prefs.getString("User_image"));

      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title:Container(
              color: Colors.white,
              //margin: const EdgeInsets.only(left:20,right: 20,top: 20),
              child:  Text("Profile",
               style: TextStyle(
               color: Colors.black,
                fontFamily:"Raleway",
                fontSize: 32,
                fontWeight: FontWeight.bold,
                 ),
               ),
              ),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
                              Stack(
                        fit: StackFit.passthrough,
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                        Container(
                         alignment: Alignment.center,
                         margin: const EdgeInsets.only( top: 40,bottom: 20,left: 20,right: 20),
                         height: 120,
                         width: 120,
                         decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(22),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                              image: _imageprofile!=null? MemoryImage(_imageprofile) : AssetImage("images/avatar.png"),
                          ),
                          color: Colors.grey,
                         ),
                        ),
                        GestureDetector(
                          onTap: (){
                            _showDialog();
                          },
                          child: Container(
                            alignment: Alignment.bottomRight,
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.all(8),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(100, 0, 0, 0),
                                  //  spreadRadius: 1,
                                  blurRadius: 2,
                                ),
                              ],
                              //borderRadius: BorderRadius.circular(22),
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child:Icon(Icons.photo_camera, color: Colors.black,),
                          ),
                        ),

                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child:  TextField(
                        textInputAction: TextInputAction.done,
                        keyboardType:TextInputType.text,
                        controller: controller ,
                        decoration: InputDecoration(
                          hintText: "Name",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                            color: Color.fromARGB(255,229, 229, 229),
                            width: 2, 
                        ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                            color: Color.fromARGB(255,0, 0, 0),
                            width: 2, 
                        ),
                          ),
                        ),
                      ),
                      ),
                     GestureDetector(
                       child: Container(
                         alignment: Alignment.center,
                         constraints:BoxConstraints.expand(height: 44),
                         padding: const EdgeInsets.all(12),
                         margin: const EdgeInsets.all(20),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(22),
                           color: Colors.indigo,
                         ),
                         child: Align(
                           alignment: Alignment.center,
                           child:Text(
                             "Submit",
                             style: TextStyle(
                               fontSize: 16,
                               color: Colors.white,
                             ),
                           ),
                         ),
                       ),
                       onTap:()=>_submitData(),
                     ),

                   
          ],
        ),
    );

  //  return Container(
  //    padding: const EdgeInsets.all(20),
  //    child: SingleChildScrollView(
  //      child:Column(
  //        mainAxisAlignment: MainAxisAlignment.start,
  //        mainAxisSize:MainAxisSize.max,
  //      children: <Widget>[
  //        Container(
  //         alignment: Alignment.centerLeft,
  //             color: Colors.white,
  //             margin: const EdgeInsets.only(top: 10),
  //             child:  Text("Profile",
  //              style: TextStyle(
  //              color: Colors.black,
  //               fontFamily:"Raleway",
  //               fontSize: 32,
  //               fontWeight: FontWeight.bold,
  //                ),
  //              ),
  //             ),
  //               Stack(
  //                       fit: StackFit.passthrough,
  //                       alignment: Alignment.bottomRight,
  //                       children: <Widget>[
  //                       Container(
  //                        alignment: Alignment.center,
  //                        margin: const EdgeInsets.only( top: 40,bottom: 20,left: 20,right: 20),
  //                        height: 120,
  //                        width: 120,
  //                        decoration: BoxDecoration(
  //                         //borderRadius: BorderRadius.circular(22),
  //                         shape: BoxShape.circle,
                          
  //                         color: Colors.yellow,
  //                        ),
  //                        child:Image.asset("images/avatar.png"),
  //                       ),
  //                       Container(
  //                        alignment: Alignment.bottomRight,
  //                        margin: const EdgeInsets.all(20),
  //                        padding: const EdgeInsets.all(8),
  //                        height: 40,
  //                        width: 40,
  //                        decoration: BoxDecoration(
  //                          boxShadow: [
  //                             BoxShadow(
  //                               color: Color.fromARGB(100, 0, 0, 0),
  //                               //  spreadRadius: 1,
  //                               blurRadius: 2,
  //                             ),
  //                           ],
  //                         //borderRadius: BorderRadius.circular(22),
  //                         shape: BoxShape.circle,
  //                         color: Colors.white,
  //                        ),
  //                        child:Icon(Icons.photo_camera, color: Colors.black,),
  //                       ),
  //                       ],
  //                     ),
  //                     Container(
  //                       margin: const EdgeInsets.all(20),
  //                       child:  TextField(
  //                       textInputAction: TextInputAction.done,
  //                       keyboardType:TextInputType.text,
  //                       decoration: InputDecoration(
  //                         hintText: "Name",
  //                         enabledBorder: UnderlineInputBorder(
  //                           borderSide: BorderSide(
  //                           color: Color.fromARGB(255,229, 229, 229),
  //                           width: 2, 
  //                       ),
  //                         ),
  //                         focusedBorder: UnderlineInputBorder(
  //                           borderSide: BorderSide(
  //                           color: Color.fromARGB(255,0, 0, 0),
  //                           width: 2, 
  //                       ),
  //                         ),
  //                       ),
  //                     ),
  //                     ),
  //                    Container(
  //                       alignment: Alignment.center,
  //                       constraints:BoxConstraints.expand(height: 44),
  //                       padding: const EdgeInsets.all(12),
  //                       margin: const EdgeInsets.all(20),
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(22),
  //                         color: Colors.indigo,
  //                       ),
  //                       child: Align(
  //                         alignment: Alignment.center,
  //                         child:Text(
  //                         "Submit",
  //                         style: TextStyle(
  //                           fontSize: 16,
  //                           color: Colors.white,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
                   
  //             // Expanded(
  //             //   child: Container(
  //             //     alignment: Alignment.center,
  //             //     padding: const EdgeInsets.all(20),
  //             //     child: Column(
  //             //       children: <Widget>[
  //             //        ],
  //             //     ),
  //             //   ),
  //             //   ),
  //      ],
  //    ),
  //    ),
      
  //  );
  }

  _submitData() async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if(controller.text.length<3)
    {
      Fluttertoast.showToast(
          msg: "Please check name , name will of min 3 letter",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.black87,
          fontSize: 16.0
      );
    }
    else{
      _nameprofile=controller.text;
      preferences.setString("User_name",_nameprofile);

      if(_imageprofile!=null)
      {
//        List<int> imageBytes = _imageprofile.readAsBytesSync();
//        print(imageBytes);
        String base64Image = base64Encode(_imageprofile);

        preferences.setString("User_image",base64Image);
        print(preferences.getString("User_image"));
        Fluttertoast.showToast(
            msg: "Info saved",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            backgroundColor: Colors.black87,
            fontSize: 16.0
        );

      }
      else{
        Fluttertoast.showToast(
            msg: "Please upload Profile picture",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            backgroundColor: Colors.black87,
            fontSize: 16.0
        );
      }
    }
  }

  _showDialog()
  {
    showDialog(
        context: context,
      builder: (BuildContext context){
          return Dialog(
            child: Container(
              height: 200,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      "Choose Image From",
                      style: TextStyle(color: Colors.black,fontSize: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        "Camera",
                        style: TextStyle(color: Colors.black,fontSize: 16,
                        ),
                      ),
                    ),
                    onTap:()=> _openCamera(),
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        "Gallery",
                        style: TextStyle(color: Colors.black,fontSize: 16,
                        ),
                      ),
                    ) ,
                    onTap:()=> _openGallery(),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "CLOSE",
                              style: TextStyle(color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
      }
    );
  }

  Future _openCamera() async
  {
    Navigator.of(context).pop();
    var pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    _imageprofile=File(pickedFile.path);
    List<int> imageBytes = _imageprofile.readAsBytesSync();
    print(imageBytes);
    String base64Image = base64Encode(imageBytes);

    setState(() {
      _imageprofile = base64Decode(base64Image);
    });
  }

  Future _openGallery() async
  {
    Navigator.of(context).pop();
    var pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    _imageprofile=File(pickedFile.path);
    List<int> imageBytes = _imageprofile.readAsBytesSync();
    print(imageBytes);
    String base64Image = base64Encode(imageBytes);

    setState(() {
      _imageprofile = base64Decode(base64Image);

    });

  }
  
}
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/admin/screens/homeadmin/admin_screen.dart';
import 'package:apporder/screens/admin/screens/newsview/newsview_screen.dart';
import 'package:apporder/utils/custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Contents extends StatefulWidget {
  const Contents({Key? key}) : super(key: key);

  @override
  _ContentsState createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  final TextEditingController content = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController star = TextEditingController();
  final TextEditingController show = TextEditingController();
  String image = '';

  PlatformFile? file1;
  String link1 = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 550,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        SizedBox(width: 110, child: Text("Title:")),
                        SizedBox(width: 25),
                        buildTextField(
                            FontAwesomeIcons.userAlt,
                            "Title",
                            false,
                            false,
                            Responsive.getSize(context).width * 0.5,
                            title,
                            true),
                        Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        SizedBox(width: 110, child: Text("Content:")),
                        SizedBox(width: 25),
                        buildTextField(
                            FontAwesomeIcons.envelope,
                            "Content",
                            false,
                            false,
                            Responsive.getSize(context).width * 0.5,
                            content,
                            true),
                        Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        SizedBox(width: 110, child: Text("Hot:")),
                        SizedBox(width: 25),
                        buildTextField(
                            FontAwesomeIcons.lock,
                            "1-0",
                            false,
                            false,
                            Responsive.getSize(context).width * 0.5,
                            show,
                            true),
                        Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        SizedBox(width: 110, child: Text("Star:")),
                        SizedBox(width: 25),
                        buildTextField(
                            FontAwesomeIcons.userAlt,
                            "1-5",
                            false,
                            false,
                            Responsive.getSize(context).width * 0.5,
                            star,
                            true),
                        Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        SizedBox(width: 110, child: Text("Image Main:")),
                        Spacer(),
                        file1 != null
                            ? Stack(
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Color(0xffe7e7e7),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 3,
                                            color: Color(0xffa6a6a6),
                                            offset: Offset(2, 2),
                                          ),
                                          BoxShadow(
                                            blurRadius: 3,
                                            color: Color(0xffffffff),
                                            offset: Offset(-2, -2),
                                          ),
                                        ],
                                        gradient: LinearGradient(
                                          stops: [0, 1],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xffd0d0d0),
                                            Color(0xfff7f7f7)
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(
                                          15,
                                        ))),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () async {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles();
                                          if (result != null) {
                                            setState(() {
                                              file1 = result.files.first;
                                            });
                                          } else {
                                            // User canceled the picker
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.memory(
                                            file1!.bytes!,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 5,
                                    top: 5,
                                    child: InkWell(
                                      child: Icon(
                                        Icons.remove_circle,
                                        size: 20,
                                        color: Colors.red,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          file1 = null;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Color(0xffe7e7e7),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0xffa6a6a6),
                                        offset: Offset(2, 2),
                                      ),
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0xffffffff),
                                        offset: Offset(-2, -2),
                                      ),
                                    ],
                                    gradient: LinearGradient(
                                      stops: [0, 1],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xffd0d0d0),
                                        Color(0xfff7f7f7)
                                      ],
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(
                                      15,
                                    ))),
                                child: Center(
                                  child: IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles();
                                      if (result != null) {
                                        setState(() {
                                          file1 = result.files.first;
                                        });
                                      } else {
                                        // User canceled the picker
                                      }
                                    },
                                  ),
                                ),
                              ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Center(
                      child: RaisedButton(
                        onPressed: () async {
                          if (content.text != '' &&
                              title.text != '' &&
                              show.text != '' &&
                              star.text != '' &&
                              file1 != null) {
                            String url =
                                "https://tyhoang.ga/images/api_anh.php";
                            String name1 = file1!.name;
                            List<String> newname1 = name1.split(".");
                            String base641 = uint8ListTob64(file1!.bytes!);

                            final response1 =
                                await http.post(Uri.parse(url), body: {
                              "base64": base641,
                              "name": name1,
                            });
                            if (response1.body.toString() == "1") {
                              link1 = newname1[0];
                            }

                            setState(() {
                              if (content.text != '' &&
                                  title.text != '' &&
                                  show.text != '' &&
                                  star.text != '' &&
                                  file1 != null) {
                                DocumentReference k = FirebaseFirestore.instance
                                    .collection("news")
                                    .doc();
                                k.set({
                                  "content": content.text,
                                  "title": title.text,
                                  "highlights": num.parse("1"),
                                  "star": num.parse(star.text),
                                  "hot": num.parse(show.text),
                                  "image":
                                      "https://www.tyhoang.ga/images/uploads/" +
                                          link1 +
                                          ".png",
                                });
                              }
                            });
                            FluroRouters.router.navigateTo(
                              context,
                              NewsviewScreen.routeName,
                              replace: true,
                            );
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: Text(
                          'Save Change',
                          style: TextStyle(color: Colors.blue),
                        ),
                        textColor: Colors.white,
                        splashColor: Colors.red,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
      IconData icon,
      String hintText,
      bool isPassword,
      bool isEmail,
      double width,
      TextEditingController controller,
      bool checkT) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9.0),
      child: Container(
        width: width,
        decoration: BoxDecoration(
            color: Color(0xFFEBEBEB),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Color(0x70000000),
                offset: Offset(-2.2, 2.6),
                blurRadius: 2,
              ),
              BoxShadow(
                color: Color(0x85D3CFCF),
                offset: -Offset(3, 1.5),
                blurRadius: 2,
              ),
            ]),
        child: TextField(
          enabled: checkT,
          controller: controller,
          obscureText: isPassword,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Palette.iconColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFEBEBEB)),
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFEBEBEB)),
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
            ),
            contentPadding: EdgeInsets.all(10),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
          ),
        ),
      ),
    );
  }

  String uint8ListTob64(Uint8List uint8list) {
    String base64String = base64Encode(uint8list);
    String header = "data:image/png;base64,";
    return header + base64String;
  }
}

// https://tamnguyen.com.vn/thiet-ke-website-do-an-vie-food.html

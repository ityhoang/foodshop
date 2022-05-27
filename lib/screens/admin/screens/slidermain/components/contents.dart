// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:apporder/responsive/responsive_screen.dart';
import 'package:apporder/routes.dart';
import 'package:apporder/screens/admin/screens/homeadmin/admin_screen.dart';
import 'package:apporder/screens/admin/screens/slidermain/slidemain_screen.dart';
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
  final TextEditingController names1 = TextEditingController();
  final TextEditingController names2 = TextEditingController();
  final TextEditingController names3 = TextEditingController();
  final TextEditingController names4 = TextEditingController();
  final TextEditingController names5 = TextEditingController();
  final TextEditingController names6 = TextEditingController();
  String image = '';
  String selectedValue = "food";
  PlatformFile? file1;
  PlatformFile? file2;
  PlatformFile? file3;
  PlatformFile? file4;
  PlatformFile? file5;
  PlatformFile? file6;
  String link1 = '';
  String link2 = '';
  String link3 = '';
  String link4 = '';
  String link5 = '';
  String link6 = '';
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
                        SizedBox(width: 110, child: Text("Name 1:")),
                        SizedBox(width: 25),
                        buildTextField(
                            FontAwesomeIcons.userAlt,
                            "Name 1",
                            false,
                            false,
                            Responsive.getSize(context).width * 0.5,
                            names1,
                            true),
                        Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        SizedBox(width: 110, child: Text("Name 2:")),
                        SizedBox(width: 25),
                        buildTextField(
                            FontAwesomeIcons.envelope,
                            "Name 2",
                            false,
                            false,
                            Responsive.getSize(context).width * 0.5,
                            names2,
                            true),
                        Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        SizedBox(width: 110, child: Text("Name 3:")),
                        SizedBox(width: 25),
                        buildTextField(
                            FontAwesomeIcons.lock,
                            "Name 3",
                            false,
                            false,
                            Responsive.getSize(context).width * 0.5,
                            names3,
                            true),
                        Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        SizedBox(width: 110, child: Text("Name 4")),
                        SizedBox(width: 25),
                        buildTextField(
                            FontAwesomeIcons.userAlt,
                            "Name 4",
                            false,
                            false,
                            Responsive.getSize(context).width * 0.5,
                            names4,
                            true),
                        Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        SizedBox(width: 110, child: Text("Name 5:")),
                        SizedBox(width: 25),
                        buildTextField(
                            FontAwesomeIcons.lock,
                            "Name 5",
                            false,
                            false,
                            Responsive.getSize(context).width * 0.5,
                            names5,
                            true),
                        Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        SizedBox(width: 110, child: Text("Name 6")),
                        SizedBox(width: 25),
                        buildTextField(
                            FontAwesomeIcons.userAlt,
                            "Name 6",
                            false,
                            false,
                            Responsive.getSize(context).width * 0.5,
                            names6,
                            true),
                        Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        SizedBox(width: 110, child: Text("List Image:")),
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
                        SizedBox(
                          width: 15,
                        ),
                        file2 != null
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
                                              file2 = result.files.first;
                                            });
                                          } else {
                                            // User canceled the picker
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.memory(
                                            file2!.bytes!,
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
                                          file2 = null;
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
                                          file2 = result.files.first;
                                        });
                                      } else {
                                        // User canceled the picker
                                      }
                                    },
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: 15,
                        ),
                        file3 != null
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
                                              file3 = result.files.first;
                                            });
                                          } else {
                                            // User canceled the picker
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.memory(
                                            file3!.bytes!,
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
                                          file3 = null;
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
                                          file3 = result.files.first;
                                        });
                                      } else {
                                        // User canceled the picker
                                      }
                                    },
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: 15,
                        ),
                        file4 != null
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
                                              file4 = result.files.first;
                                            });
                                          } else {
                                            // User canceled the picker
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.memory(
                                            file4!.bytes!,
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
                                          file4 = null;
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
                                          file4 = result.files.first;
                                        });
                                      } else {
                                        // User canceled the picker
                                      }
                                    },
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: 15,
                        ),
                        file5 != null
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
                                              file5 = result.files.first;
                                            });
                                          } else {
                                            // User canceled the picker
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.memory(
                                            file5!.bytes!,
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
                                          file5 = null;
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
                                          file5 = result.files.first;
                                        });
                                      } else {
                                        // User canceled the picker
                                      }
                                    },
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: 15,
                        ),
                        file6 != null
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
                                              file6 = result.files.first;
                                            });
                                          } else {
                                            // User canceled the picker
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.memory(
                                            file6!.bytes!,
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
                                          file6 = null;
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
                                          file6 = result.files.first;
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
                          if (names1.text != '' &&
                              names2.text != '' &&
                              names3.text != '' &&
                              names4.text != '' &&
                              names5.text != '' &&
                              names6.text != '' &&
                              file1 != null &&
                              file2 != null &&
                              file3 != null &&
                              file4 != null &&
                              file5 != null) {
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

                            String name2 = file2!.name;
                            List<String> newname2 = name2.split(".");
                            String base642 = uint8ListTob64(file2!.bytes!);

                            final response2 =
                                await http.post(Uri.parse(url), body: {
                              "base64": base642,
                              "name": name2,
                            });
                            if (response1.body.toString() == "1") {
                              link2 = newname2[0];
                            }

                            String name3 = file3!.name;
                            List<String> newname3 = name3.split(".");
                            String base643 = uint8ListTob64(file3!.bytes!);

                            final response3 =
                                await http.post(Uri.parse(url), body: {
                              "base64": base643,
                              "name": name3,
                            });
                            if (response3.body.toString() == "1") {
                              link3 = newname3[0];
                            }

                            String name4 = file4!.name;
                            List<String> newname4 = name4.split(".");
                            String base644 = uint8ListTob64(file4!.bytes!);

                            final response4 =
                                await http.post(Uri.parse(url), body: {
                              "base64": base644,
                              "name": name4,
                            });
                            if (response4.body.toString() == "1") {
                              link4 = newname4[0];
                            }

                            String name5 = file5!.name;
                            List<String> newname5 = name5.split(".");
                            String base645 = uint8ListTob64(file5!.bytes!);

                            final response5 =
                                await http.post(Uri.parse(url), body: {
                              "base64": base645,
                              "name": name5,
                            });
                            if (response5.body.toString() == "1") {
                              link5 = newname5[0];
                            }

                            String name6 = file6!.name;
                            List<String> newname6 = name6.split(".");
                            String base646 = uint8ListTob64(file6!.bytes!);

                            final response6 =
                                await http.post(Uri.parse(url), body: {
                              "base64": base646,
                              "name": name6,
                            });
                            if (response6.body.toString() == "1") {
                              link6 = newname6[0];
                            }

                            setState(() {
                              if (names1.text != '' &&
                                  names2.text != '' &&
                                  names3.text != '' &&
                                  names4.text != '' &&
                                  names5.text != '' &&
                                  names6.text != '' &&
                                  file1 != null &&
                                  file2 != null &&
                                  file3 != null &&
                                  file4 != null &&
                                  file5 != null) {
                                CollectionReference k = FirebaseFirestore
                                    .instance
                                    .collection("imageslider");
                                k.doc("8sDBmqD6UWkvvBDFXCZu").set({
                                  "name": names1.text,
                                  "image":
                                      "https://www.tyhoang.ga/images/uploads/" +
                                          link1 +
                                          ".png",
                                });
                                k.doc("BmIBKKlnKt8CKgkzy6Qr").set({
                                  "name": names2.text,
                                  "image":
                                      "https://www.tyhoang.ga/images/uploads/" +
                                          link2 +
                                          ".png",
                                });
                                k.doc("IzjRU5xMfKa6MHb7ZcM6").set({
                                  "name": names3.text,
                                  "image":
                                      "https://www.tyhoang.ga/images/uploads/" +
                                          link3 +
                                          ".png",
                                });
                                k.doc("M2LFJxcaRWxyeqecN8cR").set({
                                  "name": names4.text,
                                  "image":
                                      "https://www.tyhoang.ga/images/uploads/" +
                                          link4 +
                                          ".png",
                                });
                                k.doc("RjNLYsSrI4tKUJATzxCf").set({
                                  "name": names5.text,
                                  "image":
                                      "https://www.tyhoang.ga/images/uploads/" +
                                          link5 +
                                          ".png",
                                });
                                k.doc("uFIT6e48jttMgO7awyqG").set({
                                  "name": names6.text,
                                  "image":
                                      "https://www.tyhoang.ga/images/uploads/" +
                                          link6 +
                                          ".png",
                                });
                              }
                            });
                            FluroRouters.router.navigateTo(
                              context,
                              SlidermainScreen.routeName,
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

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Food"), value: "food"),
      DropdownMenuItem(child: Text("Drink"), value: "drink"),
      DropdownMenuItem(child: Text("Snack"), value: "snack"),
      DropdownMenuItem(child: Text("Veges"), value: "veges"),
      DropdownMenuItem(child: Text("Dessert"), value: "dessert"),
    ];
    return menuItems;
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

  Future<String> getLink(PlatformFile? files) async {
    String name1 = files!.name;
    List<String> newname = name1.split(".");
    String base64 = uint8ListTob64(files.bytes!);
    String url = "https://tyhoang.ga/images/api_anh.php";
    final response = await http.post(Uri.parse(url), body: {
      "base64": base64,
      "name": name1,
    });
    if (response.body.toString() == "1") {
      return newname[0];
    }
    return "";
  }
}

// https://tamnguyen.com.vn/thiet-ke-website-do-an-vie-food.html

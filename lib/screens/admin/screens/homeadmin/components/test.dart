// import 'dart:io';

// import 'package:flutter/material.dart';

// class SingleImageUpload extends StatefulWidget {
//   @override
//   _SingleImageUploadState createState() {
//     return _SingleImageUploadState();
//   }
// }

// class _SingleImageUploadState extends State<SingleImageUpload> {
//   List<ImageUploadModel> images = [];
//   late Future<File> _imageFile;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new Scaffold(
//         appBar: new AppBar(
//           centerTitle: true,
//           title: const Text('Plugin example app'),
//         ),
//         body: Column(
//           children: <Widget>[
//             Expanded(
//               child: buildGridView(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildGridView() {
//     return GridView.count(
//       shrinkWrap: true,
//       crossAxisCount: 3,
//       childAspectRatio: 1,
//       children: List.generate(images.length, (index) {
//         if (images[index] is ImageUploadModel) {
//           ImageUploadModel uploadModel = images[index];
//           return Card(
//             clipBehavior: Clip.antiAlias,
//             child: Stack(
//               children: <Widget>[
//                 Image.file(
//                   uploadModel.imageFile,
//                   width: 300,
//                   height: 300,
//                 ),
//                 Positioned(
//                   right: 5,
//                   top: 5,
//                   child: InkWell(
//                     child: Icon(
//                       Icons.remove_circle,
//                       size: 20,
//                       color: Colors.red,
//                     ),
//                     onTap: () {},
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           return Card(
//             child: IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () {
//                 _onAddImageClick(index);
//               },
//             ),
//           );
//         }
//       }),
//     );
//   }

//   Future _onAddImageClick(int index) async {
//     setState(() {
//       _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
//       getFileImage(index);
//     });
//   }

//   void getFileImage(int index) async {
// //    var dir = await path_provider.getTemporaryDirectory();

//     _imageFile.then((file) async {
//       setState(() {
//         ImageUploadModel imageUpload = new ImageUploadModel(
//             isUploaded: false, uploading: false, imageFile: file, imageUrl: '');

//         images.replaceRange(index, index + 1, [imageUpload]);
//       });
//     });
//   }
// }

// class ImageUploadModel {
//   bool isUploaded;
//   bool uploading;
//   File imageFile;
//   String imageUrl;

//   ImageUploadModel({
//     required this.isUploaded,
//     required this.uploading,
//     required this.imageFile,
//     required this.imageUrl,
//   });
// }

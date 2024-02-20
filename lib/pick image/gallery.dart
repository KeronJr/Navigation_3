// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class GalleryPage extends StatefulWidget {
//   @override
//   _GalleryPageState createState() => _GalleryPageState();
// }

// class _GalleryPageState extends State<GalleryPage> {
//   List<ImageFile> images = [];

//   @override
//   void initState() {
//     super.initState();
//     loadAssets();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gallery'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.check),
//             onPressed: () {
//               // Handle selection
//               List<ImageFile> selectedImages =
//                   images.where((image) => image.isSelected).toList();
//               Navigator.pop(context, selectedImages);
//             },
//           ),
//         ],
//       ),
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 4.0,
//           mainAxisSpacing: 4.0,
//         ),
//         itemCount: images.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onLongPress: () {
//               // Handle long press to select image
//               setState(() {
//                 // Toggle selection state
//                 images[index].isSelected = !images[index].isSelected;
//               });
//             },
//             child: Stack(
//               children: [
//                 Image.file(
//                   File(images[index].path),
//                   fit: BoxFit.cover,
//                 ),
//                 if (images[index].isSelected)
//                   Positioned(
//                     top: 4.0,
//                     right: 4.0,
//                     child: Icon(
//                       Icons.check_circle,
//                       color: Colors.green,
//                     ),
//                   ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<void> loadAssets() async {
//     try {
//       final List<XFile>? result = await ImagePicker().pickMultiImage();
//       if (result != null) {
//         setState(() {
//           // Initialize images list and set isSelected property to false for each image
//           images = result
//               .map((file) => ImageFile(path: file.path, isSelected: false))
//               .toList();
//         });
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }

// class ImageFile {
//   final String path;
//   bool isSelected;

//   ImageFile({required this.path, required this.isSelected});
// }




// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Gallery',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: GalleryPage(),
//     );
//   }
// }

// class GalleryPage extends StatefulWidget {
//   @override
//   _GalleryPageState createState() => _GalleryPageState();
// }

// class _GalleryPageState extends State<GalleryPage> {
//   List<File> _assets = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchAssets();
//   }

//   Future<void> _fetchAssets() async {
//     try {
//       // Fetch all images from the device's gallery
//       final List<XFile>? images = await ImagePicker().pickMultiImage();

//       if (images != null) {
//         List<File> imageFiles =
//             images.map((image) => File(image.path)).toList();
//         setState(() {
//           _assets = imageFiles;
//         });
//       }
//     } catch (e) {
//       print('Error fetching assets: $e');
//       // Handle the error (e.g., show a snackbar, display an error message)
//     }
//   }

//   void _onAssetTap(File asset) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FullScreenView(asset: asset),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gallery'),
//       ),
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 4.0,
//           mainAxisSpacing: 4.0,
//         ),
//         itemCount: _assets.length,
//         itemBuilder: (BuildContext context, int index) {
//           final asset = _assets[index];
//           return GestureDetector(
//             onTap: () => _onAssetTap(asset),
//             child: AssetThumbnail(asset: asset),
//           );
//         },
//       ),
//     );
//   }
// }

// class AssetThumbnail extends StatelessWidget {
//   final File asset;

//   const AssetThumbnail({required this.asset});

//   @override
//   Widget build(BuildContext context) {
//     return Image.file(
//       asset,
//       fit: BoxFit.cover,
//     );
//   }
// }

// class FullScreenView extends StatelessWidget {
//   final File asset;

//   const FullScreenView({required this.asset});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Full Screen View'),
//       ),
//       body: Center(
//         child: Hero(
//           tag: 'asset',
//           child: Image.file(asset),
//         ),
//       ),
//     );
//   }
// }

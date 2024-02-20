import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigation_assignment_2/contacts.dart';
import 'package:navigation_assignment_2/pick%20image/gallery.dart';
import 'package:navigation_assignment_2/pick%20image/pick_image.dart';
import 'package:navigation_assignment_2/screens/welcome_screen.dart';
import 'package:navigation_assignment_2/theme_provider.dart';
import 'package:provider/provider.dart';

class DrawerNavigation extends StatefulWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;

  const DrawerNavigation({
    required this.onItemSelected,
    required this.selectedIndex,
  });

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object>? avatarImage;
    if (_image != null) {
      avatarImage = MemoryImage(_image!);
    } else {
      avatarImage = NetworkImage(
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
      );
    }

    return Drawer(
      width: 300.0,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(243, 131, 33, 1),
                      ),
                      accountName: Text(
                        "Keron 's Menu ",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      accountEmail: Text(
                        " ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      currentAccountPicture: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PickImage(
                                onImageSelected: _setImage,
                                initialImage: _image,
                              ),
                            ),
                          );
                        },
                        //   child: Stack(
                        //     children: [
                        //       CircleAvatar(
                        //         radius: 50,
                        //         backgroundImage: avatarImage,
                        //       ),
                        //       Positioned(
                        //         bottom: 0,
                        //         right: 0,
                        //         child: IconButton(
                        //           icon: Icon(Icons.edit),
                        //           onPressed: () {
                        //             Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                 builder: (context) => PickImage(
                        //                   onImageSelected: _setImage,
                        //                   initialImage: _image,
                        //                 ),
                        //               ),
                        //             );
                        //           },
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                      ),
                    ),
                    _buildListTile('Home', Icons.home, 0),
                    _buildListTile('Calculator', Icons.calculate, 1),
                    _buildListTile('About', Icons.info, 2),
                    _buildListTile('Logout', Icons.logout, 5),
                    // _buildListTile('Contacts', Icons.contact_emergency, 3),
                    // _buildListTile('Gallery', Icons.photo, 4),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Transform.scale(
              scale: 1.5,
              child: Switch(
                value: context
                    .select((ThemeStateProvider theme) => theme.isDarkTheme),
                onChanged: (newValue) {
                  context.read<ThemeStateProvider>().setDarkTheme(newValue);
                  if (!newValue) {
                    _showSnackbar(context, 'You are in Light mode');
                  } else {
                    _showSnackbar(context, 'You are in Dark mode');
                  }
                },
                activeTrackColor: Colors.grey,
                activeColor: Colors.grey[300],
                inactiveTrackColor: Colors.grey,
                inactiveThumbColor: Colors.yellow,
                activeThumbImage: AssetImage('assets/images/dark.png'),
                inactiveThumbImage: AssetImage('assets/images/light.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, int index) {
    bool isSelected = widget.selectedIndex == index;
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: () {
        if (title == 'Logout') {
          Navigator.pop(context); // Close the drawer
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
          );
        } else if (title == 'Contacts') {
          Navigator.pop(context); // Close the drawer
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Contacts()),
          );
        }
        // else if (title == 'Gallery') {
        //   Navigator.pop(context); // Close the drawer
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => GalleryPage()),
        //   );
        // }
        else {
          widget.onItemSelected(index);
          Navigator.pop(context); // Close the drawer
        }
      },
      selected: isSelected,
      tileColor: isSelected ? Colors.green.withOpacity(0.2) : null,
      selectedTileColor: Colors.green.withOpacity(0.2),
    );
  }

  void _setImage(Uint8List image) {
    setState(() {
      _image = image;
    });
  }
}

// // Function to pick an image from the camera
// Future<void> _pickImageFromCamera() async {
//   final pickedImage = await ImagePicker().pickImage(
//     source: ImageSource.camera,
//   );
//   if (pickedImage != null) {
//     setState(() {
//       _image = File(pickedImage.path).readAsBytesSync();
//     });
//   }
// }

// // Function to pick an image from the gallery
// Future<void> _pickImageFromGallery() async {
//   final pickedImage = await ImagePicker().pickImage(
//     source: ImageSource.gallery,
//   );
//   if (pickedImage != null) {
//     setState(() {
//       _image = File(pickedImage.path).readAsBytesSync();
//     });
//   }
// }

//   void _setImage(Uint8List image) {
//     setState(() {
//       _image = image;
//     });
//   }
// }

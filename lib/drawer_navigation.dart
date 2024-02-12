import 'package:flutter/material.dart';

class DrawerNavigation extends StatelessWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;
  final BuildContext context;

  const DrawerNavigation({
    required this.onItemSelected,
    required this.selectedIndex,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(243, 131, 33, 1),
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Keron's Menu",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          _buildListTile('Home', Icons.home, 0),
          _buildListTile('Calculator', Icons.calculate, 1),
          _buildListTile('About', Icons.info, 2),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, int index) {
    bool isSelected = selectedIndex == index;
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: () {
        onItemSelected(index);
        Navigator.pop(context);
      },
      selected: isSelected, // Set selected property based on condition
      tileColor: isSelected
          ? Colors.green.withOpacity(0.2)
          : null, // Set background color for selected item
      selectedTileColor: Colors.green
          .withOpacity(0.2), // Set background color for selected item
    );
  }
}

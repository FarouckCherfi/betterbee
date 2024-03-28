import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Function(int) onItemTapped;
  final int selectedIndex;

  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () => onItemTapped(0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home_filled,
                    color: selectedIndex == 0 ? Colors.blue : Colors.grey),
                const Padding(
                  padding: EdgeInsets.only(
                      top:
                          2.0), // Réduire l'espace entre l'icône et le texte ici
                  child: Text('Home',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(
              width: 20), // Espacement entre les éléments de la navigation
          GestureDetector(
            onTap: () => onItemTapped(1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.park,
                    color: selectedIndex == 1 ? Colors.blue : Colors.grey),
                const Padding(
                  padding:
                      EdgeInsets.only(top: 2.0), // Ajustez selon vos besoins
                  child: Text('Park',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20), // Adjust spacing as needed
          GestureDetector(
            onTap: () => onItemTapped(2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.contacts,
                    color: selectedIndex == 2 ? Colors.blue : Colors.grey),
                const Padding(
                  padding:
                      EdgeInsets.only(top: 2.0), // Ajustez selon vos besoins
                  child: Text('Contacts', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}

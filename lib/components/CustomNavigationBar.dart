import 'package:betterbee/Provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          Provider.of<AppProvider>(context).selectedAnimal
              ? GestureDetector(
                  onTap: () => {
                    onItemTapped(1),
                    Provider.of<AppProvider>(listen: false, context)
                        .setSelectedAnimal(false),
                    Provider.of<AppProvider>(listen: false, context)
                        .setDetail(false)
                  },
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
                      Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Text('Back',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        // Réduire l'espace entre l'icône et le texte ici
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () => {
              onItemTapped(0),
              Provider.of<AppProvider>(listen: false, context)
                  .setSelectedAnimal(false),
              Provider.of<AppProvider>(listen: false, context).setDetail(false)
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home_filled,
                    color: selectedIndex == 0 ? Colors.amber : Colors.black),
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
            onTap: () => {
              onItemTapped(1),
              Provider.of<AppProvider>(listen: false, context)
                  .setSelectedAnimal(false),
              Provider.of<AppProvider>(listen: false, context).setDetail(false)
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.park,
                    color: selectedIndex == 1 ? Colors.amber : Colors.black),
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
            onTap: () => {
              onItemTapped(2),
              Provider.of<AppProvider>(listen: false, context)
                  .setSelectedAnimal(false),
              Provider.of<AppProvider>(listen: false, context).setDetail(false)
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.contacts,
                    color: selectedIndex == 2 ? Colors.amber : Colors.black),
                const Padding(
                  padding:
                      EdgeInsets.only(top: 2.0), // Ajustez selon vos besoins
                  child: Text('Contacts', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
          const Spacer(), // Adjust spacing as needed
          GestureDetector(
            onTap: () async => {
              await Future.delayed(
                  const Duration(milliseconds: 100)), // Un court délai
              await FirebaseAuth.instance.signOut(),
              Navigator.pushNamedAndRemoveUntil(
                  context, '/signIn', (route) => false),
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logout was sucessfull"),
                  backgroundColor: Colors.green,
                ),
              )
            },
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.logout, color: Colors.black),
                Padding(
                  padding:
                      EdgeInsets.only(top: 2.0), // Ajustez selon vos besoins
                  child: Text('Logout', style: TextStyle(fontSize: 12)),
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

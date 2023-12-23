import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  //logout from homepage

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // drawer header
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),

              // home profile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: const Text("   H O M E"),
                  onTap: () {
                    // This is already the home-screen so just pop drawer
                    Navigator.pop(context);
                  },
                ),
              ),

              // Profle Title
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: const Text("   P R O F I L E"),
                  onTap: () {
                    //  pop drawer
                    Navigator.pop(context);

                    // Navigate to the page
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),

              // Users Title
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.group,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: const Text("   U S E R S"),
                  onTap: () {
                    //  pop drawer
                    Navigator.pop(context);

                    // Navigate to the page
                    Navigator.pushNamed(context, '/users_page');
                  },
                ),
              ),
            ],
          ),

          // Log-out title
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 30),
            child: ListTile(
              leading: Icon(
                Icons.login_rounded,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: const Text("   L O G O U T"),
              onTap: () {
                // pop drawer
                Navigator.pop(context);

                //logout
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}

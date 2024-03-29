import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zenchat/Components/my_back_button.dart';
import 'package:zenchat/Components/my_list_tile.dart';
import 'package:zenchat/helper/helper_functions.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("U S E R S"),
      //   backgroundColor: Theme.of(context).colorScheme.background,
      //   elevation: 0,
      // ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("User").snapshots(),
          builder: (context, snapshot) {
            // any errors
            if (snapshot.hasError) {
              displayMessageToUser("Something went wrong", context);
            }
        
            // showing loading circle
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
        
            if (snapshot.data == null) {
              return const Text("No Data Found !!");
            }
        
            //get all users
            final users = snapshot.data!.docs;
        
            return Column(
              children: [
                // back button
                const Padding(
                  padding: EdgeInsets.only(
                    top: 55.0,
                    left: 25,
                    right:
                        25, // Added some right padding to ensure the text doesn't go too far right
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Ensure even spacing between children
                    children: [
                      MyBackButton(), // This stays on the left
        
                      Text(
                        'U S E R S',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
        
                      SizedBox(
                          width:
                              50), // Adjust the width as necessary to fine-tune the centering
                    ],
                  ),
                ),
                const SizedBox(height: 25),
        
                // list of the users in the app
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      // get individual users
                      final user = users[index];
        
                      // get data from each user
                      String username = user['username'];
                      String email = user['email'];
        
                      return MyListTile(title: username, subTitile: email);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

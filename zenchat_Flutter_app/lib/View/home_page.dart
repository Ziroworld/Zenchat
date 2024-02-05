import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zenchat/Components/my_drawer.dart';
import 'package:zenchat/Components/my_list_tile.dart';
import 'package:zenchat/Components/my_post_button.dart';
import 'package:zenchat/Components/my_textfield.dart';
import 'package:zenchat/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Accesing the firestore database
  final FirestoreDatabase database = FirestoreDatabase();

  // creating a controller
  final TextEditingController newPostController = TextEditingController();

  // post message
  void postMessage() {
    // only post the message if there is something in the textfield
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    // clear the controller if messaged is posted
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Z E N C H A T'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TEXTFIELD BOX FOR USER TO TYPE
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      hintText: "Say something...",
                      obscureText: false,
                      controller: newPostController, 
                    ),
                  ),
        
                  // Post Button
                  PostButton(
                    onTap: postMessage,
                  ),
                ],
              ),
            ),
            // POSTS
            StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot) {
                // show loading Circle
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                //get all of the posts
                final posts = snapshot.data!.docs;
        
                // no data
                if (snapshot.data == null || posts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text("No posts has been made... Posting something!"),
                    ),
                  );
                }
        
                // return as a list
                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      // get each individual post
                      final post = posts[index];
        
                      //get data from each post
                      String message = post['PostMessage'];
                      String userEmail = post['UserEmail'];
                      Timestamp timestamp = post['TimeStamp'];
        
                      // return as a list tile
                      return MyListTile(
                        title: message,
                        subTitile: userEmail
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zenchat/Components/my_drawer.dart';
import 'package:zenchat/Components/my_textfield.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // creating a controller
  final TextEditingController newPostController = TextEditingController();

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
      body: Column(
        children: [
          // TEXTFIELD BOX FOR USER TO TYPE
          Padding(
            padding: const EdgeInsets.all(25),
            child: MyTextField(
              hintText: "Say something...",
              obscureText: false,
              controller: newPostController,
            ),
          ),
          // POSTS
        ],
      ),
    );
  }
}

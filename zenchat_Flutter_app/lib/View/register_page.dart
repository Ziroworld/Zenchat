import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zenchat/Components/my_buttons.dart';
import 'package:zenchat/Components/my_textfield.dart';
import 'package:zenchat/helper/helper_functions.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text ediditing controller
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPwController = TextEditingController();

  // Register Method
  void registerUser() async {
    // show loading Circle
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    //make sure password matches
    if (passwordController.text != confirmPwController.text) {
      // pop loding screen
      Navigator.pop(context);

      // show error message
      displayMessageToUser("Password don't match!", context);
    }
    //will work only if the password works
    else {
      // try creating the user
      try {
        // create the user
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // create a user document and add to the firebase database
        createUserDocument(userCredential);

        // pop the loading ciicle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // poping loading circle
        // ignore: use_build_context_synchronously
        Navigator.pop(context);

        // display error message
        // ignore: use_build_context_synchronously
        displayMessageToUser(e.code, context);
      }
    }
  }

  // createing a new methode called user document to stoe data in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("User")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': usernameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.person,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),

            // providing space
            const SizedBox(
              height: 25,
            ),

            // App name
            const Text(
              "Z E N C H A T",
              style: TextStyle(fontSize: 30),
            ),

            // providing space
            const SizedBox(
              height: 50,
            ),

            // Username
            MyTextField(
                hintText: "Username",
                obscureText: false,
                controller: usernameController),

            const SizedBox(
              height: 15,
            ),
            // email textfield
            MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailController),

            const SizedBox(
              height: 15,
            ),

            // password textfield
            MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwordController),

            const SizedBox(
              height: 15,
            ),

            // confirm password textfield
            MyTextField(
                hintText: "Confirm Password",
                obscureText: true,
                controller: confirmPwController),

            const SizedBox(
              height: 15,
            ),

            const SizedBox(
              height: 20,
            ),
            // sign in button
            MyButton(
              text: "Register",
              onTap: registerUser,
            ),

            const SizedBox(
              height: 20,
            ),
            //don't have an account ?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have am account yet?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    " Login Here",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

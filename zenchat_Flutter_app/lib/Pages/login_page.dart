import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zenchat/Components/my_buttons.dart';
import 'package:zenchat/Components/my_textfield.dart';
import 'package:zenchat/helper/helper_functions.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  // text ediditing controller
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwrodController = TextEditingController();

  // login methode
  void login() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    await Future.delayed(const Duration(seconds: 2));

    // try Sing in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwrodController.text);

      // pop loading Circle
      if (context.mounted) Navigator.pop(context);
    }

    //display any errors
    on FirebaseAuthException catch (e) {
      //pop loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      displayMessageToUser(e.code, context);
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

            // email textfield
            MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailController),

            const SizedBox(
              height: 15,
            ),

            // password textfeild
            MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwrodController),

            const SizedBox(
              height: 15,
            ),
            // forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            // sign in button
            MyButton(
              text: "Login",
              onTap: login,
            ),

            const SizedBox(
              height: 20,
            ),
            //don't have an account ?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have am account yet?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    " Register Here",
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

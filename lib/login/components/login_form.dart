import 'package:flutter/material.dart';
import 'package:pijak_app/home_screen/homeScreen.dart';
import 'package:pijak_app/signup/signup_screen.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isObscure3 = true;
  bool visible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(userCredential.user?.email ?? "")),
      );
    } catch (e) {
      String errorMessage = 'Terjadi kesalahan saat login';
      // Mendapatkan pesan kesalahan dari exception jika ada
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? 'Terjadi kesalahan saat login';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          action: SnackBarAction(
            label: 'Tutup',
            onPressed: () {},
          ),
        ),
      );

      // Print pesan kesalahan ke konsol debugging
      print("Error during login: $errorMessage");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              hintText: "email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
            controller:
                emailController, // Ganti addressController dengan nama controller Anda
            validator: (value) {
              if (value!.length == 0) {
                return "Email cannot be empty";
              }
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return ("Please enter a valid email");
              } else {
                return null;
              }
            },
            onSaved: (value) {
              emailController.text = value!;
            },
            keyboardType: TextInputType.emailAddress,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
              validator: (value) {
                RegExp regex = new RegExp(r'^.{6,}$');
                if (value!.isEmpty) {
                  return "Password cannot be empty";
                }
                if (!regex.hasMatch(value)) {
                  return ("please enter valid password min. 6 character");
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                passwordController.text = value!;
              },
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: _login,
              child: Text("Login".toUpperCase(),
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Register();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // void route(BuildContext context) {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   var kk = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user!.uid)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       // If document exists, navigate to HomeScreen
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => HomeScreen(),
  //         ),
  //       );
  //     } else {
  //       // If document does not exist, show error message
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Document does not exist on the database'),
  //           action: SnackBarAction(
  //             label: 'Close',
  //             onPressed: () {
  //               // Perform any action on press if needed
  //             },
  //           ),
  //         ),
  //       );
  //       print('Document does not exist on the database');
  //     }
  //   });
  // }

  // void signIn(String email, String password) async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       UserCredential userCredential =
  //           await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );
  //       route(context);
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'user-not-found') {
  //         print('No user found for that email.');
  //       } else if (e.code == 'wrong-password') {
  //         print('Wrong password provided for that user.');
  //       }
  //     }
  //   }
  // }
}

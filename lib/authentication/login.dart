import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_new/authentication/signup.dart';
import 'package:fire_new/entity/admin.dart';
import 'package:fire_new/entity/student.dart';
import 'package:fire_new/entity/teacher.dart';
import 'package:fire_new/authentication/forgetpass.dart';
import 'package:fire_new/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire_new/snackbar/Utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  login({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool _obsecureText = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  double screenWidth = 0;
  double screenHeight = 0;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    print('Dispose used');
    super.dispose();
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
  }

  Color primary = Colors.deepPurple;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: screenHeight / 3.9,
                width: screenWidth,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  // color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(75),
                    bottomLeft: Radius.circular(75),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: screenWidth / 4.5,
                  ),
                )),

            // ------------------------
            // LOGIN TEXT
            Container(
              // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              margin: EdgeInsets.only(
                  top: screenHeight / 15, bottom: screenWidth / 35),
              child: Text("LOGIN",
                  style: TextStyle(
                      fontSize: screenWidth / 18,
                      fontWeight: FontWeight.bold
                  ),
              ),
            ),

            //----------------------------------
            // EMAIL TEXT AREA
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: TextField(
                controller: emailController,
                cursorColor: Colors.purple[800],
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Email Address",
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.purple[800]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.purple[800],
                  ),
                ),
              ),
            ),

            // ----------------------------------------
            // PASSWORD TEXT AREA
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: TextField(
                maxLength: 10,
                controller: passwordController,
                cursorColor: Colors.purple[800],
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.purple[800]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  prefixIcon: Icon(
                    Icons.password,
                    color: Colors.purple[800],
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obsecureText = !_obsecureText;
                      });
                    },
                    child: Icon(
                      _obsecureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.purple[800],
                    ),
                  ),
                ),
                obscureText: _obsecureText,
              ),
            ),

            //------------------------
            // FORGOT PASSWORD
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(245, 0, 0, 0),
              child: GestureDetector(
                child: Text(
                  'Forget Password',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.purple[800],
                    fontSize: 15,
                  ),
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => forgetpass()),
                ),
              ),
            ),

            //------------------------
            // LOGIN BUTTON
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.fromLTRB(125, 0, 125, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  backgroundColor: Colors.deepPurple,
                  elevation: 10,
                ),
                onPressed: signIn,
                child: Text("LOGIN"),
              ),
            ),

            //--------------------------------------
            // SIGN UP
            SizedBox(height: 100),
            InkWell(
              onTap: () => widget.onClickedSignUp,
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                      color: Color.fromARGB(255, 25, 5, 5),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    text: 'Dont have any Account? ',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: ' Sign Up',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.purple[800],
                          fontSize: 15,
                        ),
                      )
                    ]),
              ),
            ),

            //----------------------------------------
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    //var sharedPref = await SharedPreferences.getInstance();
    //sharedPref.setBool(MainPageState.KEYLOGIN, true);

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .then((value) => {navigate()});
    } on FirebaseAuthException catch (e) {
      print(e);

      utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  void navigate() {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      var log = "";

      if (emailController.text.trim().contains("@imscit.com")) {
        log = "Teacher_data";
      } else if (emailController.text.trim().contains("@glsica.com")) {
        log = "Admin_data";
      } else {
        log = "Student_data";
      }
      FirebaseFirestore.instance
          .collection(log)
          .doc(user!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          if (documentSnapshot.get('role') == "Teacher") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => teacher(),
              ),
            );
          } else if (documentSnapshot.get('role') == "Admin") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => admin(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const student(),
              ),
            );
          }
        } else {
          print('not exists');
        }
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}

/*
collection reference is only for get not for set
*/
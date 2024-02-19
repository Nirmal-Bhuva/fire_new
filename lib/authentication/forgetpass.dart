import 'package:email_validator/email_validator.dart';
import 'package:fire_new/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fire_new/snackbar/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class forgetpass extends StatefulWidget {
  const forgetpass({super.key});

  @override
  State<forgetpass> createState() => _forgetpassState();
}

class _forgetpassState extends State<forgetpass> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  double screenWidth = 0;
  double screenHeight = 0;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.purple.shade50,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)
          ),
        ),
        backgroundColor: Colors.deepPurple,
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(26),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Text(
                  'Enter your Registered email \nto reset your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: TextFormField(
                  controller: emailController,
                  cursorColor: Colors.purple[800],
                  textInputAction: TextInputAction.done,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email'
                      : null,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.fromLTRB(95, 0, 95, 0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    backgroundColor: Colors.deepPurple,
                    elevation: 10,
                  ),
                  icon: const Icon(Icons.email_outlined, size: 20),
                  label: const Text(
                    'RESET',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: verifyEmail,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future verifyEmail() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      utils.showSnackBar('Password Reset Email Sent');
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);

      utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}









// import 'package:email_validator/email_validator.dart';
// import 'package:fire_new/main.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:fire_new/snackbar/Utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
//
// class forgetpass extends StatefulWidget {
//   const forgetpass({super.key});
//
//   @override
//   State<forgetpass> createState() => _forgetpassState();
// }
//
// class _forgetpassState extends State<forgetpass> {
//   final formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text('Reset Password'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Receive an email to\nreset your password.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 24),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: emailController,
//                 cursorColor: Color.fromARGB(255, 15, 0, 0),
//                 textInputAction: TextInputAction.done,
//                 decoration: InputDecoration(labelText: 'Email'),
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: (email) =>
//                     email != null && !EmailValidator.validate(email)
//                         ? 'Enter a valid email'
//                         : null,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size.fromHeight(50),
//                 ),
//                 icon: const Icon(Icons.email_outlined, size: 32),
//                 label: const Text(
//                   'Reset Password',
//                   style: TextStyle(fontSize: 24),
//                 ),
//                 onPressed: verifyEmail,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future verifyEmail() async {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => const Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//     try {
//       await FirebaseAuth.instance
//           .sendPasswordResetEmail(email: emailController.text.trim());
//
//       utils.showSnackBar('Password Reset Email Sent');
//       navigatorKey.currentState!.popUntil((route) => route.isFirst);
//     } on FirebaseAuthException catch (e) {
//       print(e);
//
//       utils.showSnackBar(e.message);
//       Navigator.of(context).pop();
//     }
//   }
// }

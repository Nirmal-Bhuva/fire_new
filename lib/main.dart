import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fire_new/authentication/AuthPage.dart';
import 'package:fire_new/authentication/login.dart';
import 'package:fire_new/entity/teacher_module/attendence/check.dart';
import 'package:fire_new/snackbar/Utils.dart';
import 'package:fire_new/authentication/login.dart';
import 'package:fire_new/entity/admin.dart';
import 'package:fire_new/entity/teacher.dart';
import 'package:fire_new/entity/student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.red),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          } else if (snapshot.hasData) {
            try {
              var log = "";

              if (EmailValidator.validate("@imscit.com")) {
                log = "login_tecaher";
              } else if (EmailValidator.validate("@glsica.com")) {
                log = "login_admin";
              } else {
                log = "login_student";
              }

              User? user = FirebaseAuth.instance.currentUser;
              var kk = FirebaseFirestore.instance
                  .collection(log)
                  .doc(user!.uid)
                  .get()
                  .then((DocumentSnapshot documentSnapshot) {
                if (documentSnapshot.exists) {
                  //if (isLoggedIn != null) {
                  // if (isLoggedIn) {
                  if (documentSnapshot.get('role') == "Teacher") {
                    return teacher();
                  } else if (documentSnapshot.get('role') == "Admin") {
                    return admin();
                  } else {
                    return student();
                  }
                } else {
                  return AuthPage();
                }
              });
            } on FirebaseAuthException catch (e) {
              print(e);
            }
            //return AuthPage();
          } else {
            return AuthPage();
          }
          return AuthPage();
        },
      ),
    );
  }
}

/*
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  static const String KEYLOGIN = "login";
  void initState() {
    // TODO: implement initState
    super.initState();

    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          } else if (snapshot.hasData) {
            try {
              var log = "";

              if (EmailValidator.validate("@imscit.com")) {
                log = "login_tecaher";
              } else if (EmailValidator.validate("@glsica.com")) {
                log = "login_admin";
              } else {
                log = "login_student";
              }

              User? user = FirebaseAuth.instance.currentUser;
              var kk = FirebaseFirestore.instance
                  .collection(log)
                  .doc(user!.uid)
                  .get()
                  .then((DocumentSnapshot documentSnapshot) {
                if (documentSnapshot.exists) {
                  if (documentSnapshot.get('role') == "Teacher") {
                    return teacher();
                  } else if (documentSnapshot.get('role') == "Admin") {
                    return admin();
                  } else {
                    return student();
                  }
                } else {
                  return AuthPage();
                }
              });
            } on FirebaseAuthException catch (e) {
              print(e);
            }
            //return AuthPage();
          } else {
            return AuthPage();
          }
          return AuthPage();
        },
      ),*/
        );
  }

  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();

    var isLoggedIn = sharedPref.getBool(KEYLOGIN);

    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Something went wrong!'));
        } else if (snapshot.hasData) {
          try {
            var log = "";

            if (EmailValidator.validate("@imscit.com")) {
              log = "login_tecaher";
            } else if (EmailValidator.validate("@glsica.com")) {
              log = "login_admin";
            } else {
              log = "login_student";
            }

            User? user = FirebaseAuth.instance.currentUser;
            var kk = FirebaseFirestore.instance
                .collection(log)
                .doc(user!.uid)
                .get()
                .then((DocumentSnapshot documentSnapshot) {
              if (documentSnapshot.exists) {
                if (isLoggedIn != null) {
                  if (isLoggedIn) {
                    if (documentSnapshot.get('role') == "Teacher") {
                      return teacher();
                    } else if (documentSnapshot.get('role') == "Admin") {
                      return admin();
                    } else {
                      return student();
                    }
                  } else {
                    return login(
                      onClickedSignUp: () {},
                    );
                  }
                } else {
                  return login(
                    onClickedSignUp: () {},
                  );
                }
              } else {
                return AuthPage();
              }
            });
          } on FirebaseAuthException catch (e) {
            print(e);
          }
          //return AuthPage();
        } else {
          return AuthPage();
        }
        return AuthPage();
      },
    );
  }
}
*/
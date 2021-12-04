
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:usersignup/comoon.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: SignUpPage(),
  ));
}

class SignUpPage extends StatefulWidget{
  _State createState()=> _State();
}

class _State extends State<SignUpPage>{
    Future createUser(String email, String password) async {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
        );
        Common().customtoast("Account Created Succeess");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Common().customtoast("The password provided is too weak.");
        } else if (e.code == 'emai"l-already-in-use') {
          Common().customtoast("The account already exists for that email.");
        }
      } catch (e) {
        print(e);
        Common().customtoast(e.toString());
      }
    }

  TextEditingController emailControler = TextEditingController();
  TextEditingController passControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: emailControler,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))
                ),
                labelText: 'Email'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: passControler,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))
                ),
                labelText: 'Password',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  createUser(emailControler.text,passControler.text);
                },
                child: Text('Sign Up'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
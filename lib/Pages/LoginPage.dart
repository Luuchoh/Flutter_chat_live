import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/Modelo/UserChat.dart';
import 'package:flutter_live_chat/Pages/HomePage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  bool isLoading = false;
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  signIn() async{
    setState(() {
      isLoading = true;
    });

    GoogleSignInAccount? account = await googleSignIn.signIn();
    GoogleSignInAuthentication? authentication = await account?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: authentication?.accessToken,
      idToken: authentication?.idToken
    );

    User firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user!;

    if(firebaseUser != null) {

      UserChat? userChat;
      userChat = await UserChat.getUser(firebaseUser.uid);

      if(userChat == null) {
        userChat = UserChat(
          id: firebaseUser.uid,
          userName: firebaseUser.displayName,
          photoUrl: firebaseUser.photoURL,
        );

        await userChat.save();
      }

      setState(() {
        isLoading = false;
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage(userChat!)
          )
      );

    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  goHomePage(UserChat userChat){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              HomePage(userChat)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: signIn,
                child: Text(
                  'INICIAR SESION CON GOOGLE',
                  style: TextStyle(fontSize: 16.0,color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffdd4b39)
                ),
              ),
            ),
            Positioned(
              child: isLoading ? const Center(child:CircularProgressIndicator()) : Container(),
            ),
          ],
        ));
  }
}
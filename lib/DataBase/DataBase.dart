import 'package:firebase_database/firebase_database.dart';


class DataBase {

  static DatabaseReference database = FirebaseDatabase.instance.ref().child("Chat");

  static DatabaseReference tableUser = database.child("User");
  static DatabaseReference tableMessage = database.child("Message");

}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:promogo/models/promo.dart';
import 'package:promogo/models/userid.dart';
import 'package:promogo/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user obj based on FirebaseUser
  UserID _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? UserID(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<UserID> get user {
    print("In StreamUserID get user");
    print(_auth.onAuthStateChanged.first);
    return _auth.onAuthStateChanged.map((x) {
      return _userFromFirebaseUser(x);
    });
  }

// Sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// Sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// Register with email & password
  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      // Create a new document for the user with the uid
      UserID userID = _userFromFirebaseUser(user);
      await DatabaseService(userID: userID)
          .initiateUserData(name, email, [], [], 'myPreferences');
      return userID;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

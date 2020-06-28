import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:promogo/models/promo.dart';
import 'package:promogo/models/userid.dart';
import 'package:promogo/models/userprofile.dart';

class DatabaseService {
  final UserID userID;
  final CollectionReference usersCollection =
  Firestore.instance.collection('users');

  DatabaseService({this.userID});

  Future<void> initiateUserData(String name, String email, List<String> purchaseHistory,
      List<String> myPromos, String myPreferences) async {
    return await usersCollection.document(userID.uid).setData({
      'name': name,
      'email': email,
      'purchaseHistory': purchaseHistory,
      'myPromos': myPromos,
      'myPreferences': myPreferences
    });
  }

  Future<void> updateUsernameData(String name) async {
    return await usersCollection.document(userID.uid).updateData({
      'name': name,
    });
  }

  UserProfile _userProfileFromSnapshot(DocumentSnapshot snapshot) {
    print("Within UserProfile");

    return UserProfile(
        userID: userID,
        myPreferences: snapshot.data['myPreferences'],
        myPromos: [],
        name: snapshot.data['name'],
        email: snapshot.data['email'],
        purchaseHistory: [],
    );
  }

  Stream<UserProfile> get userProfile {
    return usersCollection
        .document(userID.uid)
        .snapshots()
        .map(_userProfileFromSnapshot);
  }
}

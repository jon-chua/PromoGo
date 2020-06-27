import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:promogo/models/promo.dart';

class DatabaseService {
  final String uid;
  final CollectionReference usersCollection = Firestore.instance.collection('users');
  DatabaseService({ this.uid });

  Future<void> updateUserData(String name, List<String> purchaseHistory, List<Promo> myPromos, String myPreferences) async {
    return await usersCollection.document(uid).setData({
      'name': name,
      'purchaseHistory': purchaseHistory,
      'myPromos': myPromos,
      'myPreferences': myPreferences
    });
  }

  Stream<QuerySnapshot> get profile {
    return usersCollection.snapshots();
  }
}
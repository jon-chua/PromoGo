import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:promogo/models/merchant.dart';
import 'package:promogo/models/promo.dart';
import 'package:promogo/models/userid.dart';
import 'package:promogo/models/userprofile.dart';

class DatabaseService {
  final UserID userID;
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');
  final CollectionReference promosCollection =
      Firestore.instance.collection('promos');

  DatabaseService({this.userID});

  Future<void> initiateUserData(
      String name,
      String email,
      List<String> purchaseHistory,
      List<String> myPromos,
      String myPreferences) async {
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

  Future<void> initiatePromoListData(Set<Promo> promoList) async {
    print("Initiating promo list data");
    for(Promo p in promoList) {
      Merchant m = p.merchant;
      _initiatePromoData(m.name, m.visaStoreId, m.visaMerchantId, p.name, p.discount);
    }
  }

  Future<void> _initiatePromoData(String merchantName, String visaStoreId,
      String visaMerchantId, String promoName, int discount) async {
    print("Inserting promo data");
    return await promosCollection.document(promoName).setData({
      'merchantName': merchantName,
      'visaStoreId': visaStoreId,
      'visaMerchantId': visaMerchantId,
      'discount': discount
    });
  }

  UserProfile _userProfileFromSnapshot(DocumentSnapshot snapshot) {
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

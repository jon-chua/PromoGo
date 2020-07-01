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
    for (Promo p in promoList) {
      Merchant m = p.merchant;
      _initiatePromoData(
          m.name,
          m.latitude,
          m.longitude,
          m.address,
          m.postalCode,
          m.city,
          m.visaStoreId,
          m.visaMerchantId,
          m.url,
          p.promoCode,
          p.discount,
          p.expiryDate);
    }
  }

  Future<void> _initiatePromoData(
      String merchantName,
      String latitude,
      String longitude,
      String address,
      String postalCode,
      String city,
      String visaStoreId,
      String visaMerchantId,
      String url,
      String promoName,
      int discount,
      DateTime expiryDate) async {
    print("Inserting promo data");
    return await promosCollection.document(promoName).setData({
      'merchantName': merchantName,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'postalCode': postalCode,
      'city': city,
      'visaStoreId': visaStoreId,
      'visaMerchantId': visaMerchantId,
      'url': url,
      'discount': discount,
      'expiryDate': expiryDate,
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

  Set<Promo> _promoListFromSnapshot(
      Set<Promo> promoList, DocumentSnapshot promo) {
    Merchant merchant = new Merchant(
        name: promo.data["merchantName"],
        latitude: promo.data["latitude"],
        longitude: promo.data["longitude"],
        address: promo.data["address"],
        city: promo.data["city"],
        postalCode: promo.data["postalCode"],
        url: promo.data["url"],
        visaMerchantId: promo.data["visaMerchantId"],
        visaStoreId: promo.data["visaStoreId"]);
    Promo p = new Promo(merchant: merchant, promoCode: promo.documentID);
    promoList.add(p);
    return promoList;
  }

  Future<Set<Promo>> get getPromoList async {
    Set<Promo> promoList = new Set();
    await promosCollection.getDocuments().then((querySnapShot) {
      querySnapShot.documents.forEach((promo) {
        _promoListFromSnapshot(promoList, promo);
      });
    });
    return promoList;
  }

  Stream<UserProfile> get userProfile {
    return usersCollection
        .document(userID.uid)
        .snapshots()
        .map(_userProfileFromSnapshot);
  }
}

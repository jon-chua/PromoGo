import 'package:promogo/models/promo.dart';
import 'package:promogo/models/userid.dart';

class UserProfile {

  final UserID userID;
  String myPreferences = '';
  List<Promo> myPromos = [];
  String name = '';
  String email = '';
  List<String> purchaseHistory = [];


  UserProfile({
    this.userID,
    this.myPreferences,
    this.myPromos,
    this.name,
    this.email,
    this.purchaseHistory
  });
}
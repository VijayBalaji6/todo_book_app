import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/account_model.dart';

class AccountServices {
  final CollectionReference _accountCollection =
      FirebaseFirestore.instance.collection('account');

  Stream<AccountModel> getAccountDetails() {
    try {
      return _accountCollection.doc('account_id').snapshots().map((snapshot) {
        if (snapshot.exists) {
          return AccountModel.fromJson(snapshot.toString());
        } else {
          throw Exception;
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}

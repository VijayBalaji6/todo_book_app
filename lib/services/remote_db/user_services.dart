import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/user.dart';

class UserServices {
  UserServices._internal();
  static final UserServices _instance = UserServices._internal();

  static UserServices get instance => _instance;

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<UserModel> getUser({required String userId}) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        final x = snapshot.data()?['user_data'];
        return UserModel.fromMap(x);
      } else {
        throw Exception("Cannot found ");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addUser({required UserModel userDate}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userDate.userName)
          .set({'user_data': userDate.toMap()});
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'models/user/user.dart';

class UserRepository {
  User? _user;

  final _auth = auth.FirebaseAuth.instance;
  final _firestore = firestore.FirebaseFirestore.instance;

  Future<User> getCurrentUser() async {
    final _authUsr = _auth.currentUser;

    final _queryDoc = await _firestore
        .collection('users')
        .where('email', isEqualTo: _authUsr!.email)
        .get()
        .onError(
          (error, stackTrace) => Future.error(error.toString()),
        );

    final _data = _queryDoc.docs.first.data();
    _user = User.fromJson(_data);

    return _user!;
  }
}

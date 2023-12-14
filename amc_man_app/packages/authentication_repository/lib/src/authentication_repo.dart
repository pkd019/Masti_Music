import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart' as usr;

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _auth = FirebaseAuth.instance;

  Stream<AuthenticationStatus> get status async* {
    if (_auth.currentUser == null) {
      yield AuthenticationStatus.unauthenticated;
    } else {
      yield AuthenticationStatus.authenticated;
    }
    yield* _controller.stream;
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .onError((error, stackTrace) => Future.error(error.toString()));
      final _docRef = await FirebaseFirestore.instance.collection('users').doc();
      final _docId = _docRef.id;

      final _user = usr.User(
        id: _docId,
        name: name,
        email: email,
        mobile: phone,
      );

      await _docRef.set(_user.toJson()).onError(
            (error, stackTrace) => Future.error(error.toString()),
          );

      _controller.add(AuthenticationStatus.authenticated);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return Future.error(e);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return Future.error(e);
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _controller.add(AuthenticationStatus.authenticated);
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuth Error: ${e.message}');
      return Future.error(e);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
      _controller.add(AuthenticationStatus.unauthenticated);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

  void dispose() => _controller.close();
}

import 'dart:developer';

import 'package:anti_rigging/models/user.dart';
import 'package:anti_rigging/services/db/db.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final _authInstance = FirebaseAuth.instance;
  final _db = DbService();
  Future<String> signup(AppUser user, String password) async {
    try {
      final res = await _authInstance.createUserWithEmailAndPassword(
          email: user.email!, password: password);
      //add user to db
      await _db.insertUser(user.toJson());
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return evaluateAuthCode(e.code);
    } catch (e) {
      log('$e');
      return 'Something went wrong';
    }
  }

  Future<(AppUser?, String)> login(String email, String password) async {
    try {
      final result = await _authInstance.signInWithEmailAndPassword(
          email: email, password: password);
      //user user id to get user from db
      final user = await _db.getUser(result.user!.uid);
      return (user, 'Success');
    } on FirebaseAuthException catch (e) {
      return (null, evaluateAuthCode(e.code));
    } catch (e) {
      log('$e');
      return (null, 'An error Occured');
    }
  }

  Future<void> signOut() async {
    await _authInstance.signOut();
  }

  String evaluateAuthCode(String code) {
    if (code == 'weak-password') {
      return '';
    } else if (code == 'email-already-in-use') {
      return '';
    } else {
      return 'Something went wrong';
    }
  }
}

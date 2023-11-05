import 'dart:developer';

import 'package:anti_rigging/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
  final _dbInstance = FirebaseFirestore.instance;
  Future<void> insertUser(Map<String, dynamic> user) async {
    try {
      await _dbInstance.collection('USERS').add(user);
    } catch (e) {
      log('$e');
      throw Exception('$e');
    }
  }

  Future<AppUser?> getUser(String uid) async {
    try {
      final res = await _dbInstance.collection('USERS').doc(uid).get();
      return AppUser.fromJson(res.data()!);
    } catch (e) {
      return null;
    }
  }
}

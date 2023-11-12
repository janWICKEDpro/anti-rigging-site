import 'dart:developer';

import 'package:anti_rigging/models/candidate.dart';
import 'package:anti_rigging/models/user.dart';
import 'package:anti_rigging/services/storage/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
  final _dbInstance = FirebaseFirestore.instance;
  final _storage = Storage();
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

  Future createElection(List<(String, List<Candidate>)> electionInfo) async {}
}

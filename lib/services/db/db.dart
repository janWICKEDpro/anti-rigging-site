import 'dart:developer';

import 'package:anti_rigging/models/candidate.dart';
import 'package:anti_rigging/models/election.dart';
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

  Future createElection(
      List<(String, List<Candidate>)> electionInfo, Election election) async {
    try {
      for (int i = 0; i < electionInfo.length; i++) {
        //create a role docRef
        final docRef = _dbInstance
            .collection('ELECTIONS')
            .doc('${election.electionName}')
            .set(election.toJson());
        for (var candidate in electionInfo[i].$2) {
          //store image and retrieve download url
          final imageUrl = _storage.storeImage(candidate.file!);

          //use download url to create a candidate on firestore for the roles docRef
        }
      }
    } catch (e) {
      log('Error from create Election $e');
      rethrow;
    }
  }
}

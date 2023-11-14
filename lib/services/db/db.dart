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
        await _dbInstance
            .collection('ELECTIONS')
            .doc('${election.electionName}')
            .set(election.toJson());
        final docRef = _dbInstance
            .collection('ELECTIONS')
            .doc('${election.electionName}')
            .collection('ROLE')
            .doc(electionInfo[i].$1)
            .collection('CANDIDATES');
        for (var candidate in electionInfo[i].$2) {
          //store image and retrieve download url
          final imageUrl = await _storage.storeImage(candidate.file!);

          //use download url to create a candidate on firestore for the roles docRef
          await docRef.doc().set(candidate.toJson(imageUrl));
        }
      }
    } catch (e) {
      log('Error from create Election $e');
      rethrow;
    }
  }

  //get elections
  Future<List<Election>> getElections() async {
    try {
      final elections = await _dbInstance.collection('ELECTIONS').get();
      return elections.docs.map((e) => Election.fromJson(e.data())).toList();
    } catch (e) {
      throw 'Error Fetching elections';
    }
  }

  //get active elections
  Future<List<(String, List<Candidate>)>> getActiveElection() async {
    List<(String, List<Candidate>)> electionData = [];
    try {
      final election = await _dbInstance
          .collection('ELECTIONS')
          .where('isActive', isEqualTo: true)
          .limit(1)
          .get();
      final roles = await election.docs[0].reference.collection('ROLE').get();
      for (var role in roles.docs) {
        final candidates = await role.reference.collection('CANDIDATES').get();
        final List<Candidate> arr = [];
        for (var candidate in candidates.docs) {
          arr.add(Candidate.fromJson(candidate.data()));
        }
        electionData.add(((role.id), arr));
      }
      log('$electionData');
      return electionData;
    } catch (e) {
      log('$e');
      throw 'Error occured while fetching election';
    }
  }

  //close elections
  Future<bool> closeElections(String electionName) async {
    try {
      await _dbInstance
          .collection('ELECTIONS')
          .doc(electionName)
          .update({'isActive': false});
      return true;
    } catch (e) {
      log('$e');
      throw 'Error occured while closing elections';
    }
  }

  Future<Candidate> getCandidate(
      String electioName, String role, String candidateId) async {
    try {
      final candidate = await _dbInstance
          .collection('ELECTIONS')
          .doc(electioName)
          .collection('ROLE')
          .doc(role)
          .collection('CANDIDATES')
          .doc(candidateId)
          .get();

      return Candidate.fromJson(candidate.data()!);
    } catch (e) {
      throw 'could not get candidate';
    }
  }

  Future vote(String electioName, String role, String candidateId) async {
    try {
      final candidate = await getCandidate(electioName, role, candidateId);
      int val = candidate.votes;
      val++;
      await _dbInstance
          .collection('ELECTIONS')
          .doc(electioName)
          .collection('ROLE')
          .doc(role)
          .collection('CANDIDATES')
          .doc(candidateId)
          .update({'vote': val});
      //add the role and election voted for ina new collection.
      //await _dbInstance.collection('VOTEDROLES').doc().;
    } catch (e) {
      throw 'error occured while voting';
    }
  }
}

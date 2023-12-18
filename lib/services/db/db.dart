import 'dart:developer';
import 'package:anti_rigging/models/candidate.dart';
import 'package:anti_rigging/models/election.dart';
import 'package:anti_rigging/models/user.dart';
import 'package:anti_rigging/services/storage/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
  final _dbInstance = FirebaseFirestore.instance;
  final _storage = Storage();
  Future<void> insertUser(Map<String, dynamic> user, String uid) async {
    try {
      await _dbInstance.collection('USERS').doc(uid).set(user);
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

  Future createElection(List<(String, List<Candidate>)> electionInfo, Election election) async {
    try {
      log('Trying to create');
      assert(electionInfo.isNotEmpty);
      for (int i = 0; i < electionInfo.length; i++) {
        //create a role docRef
        await _dbInstance.collection('ELECTIONS').doc('${election.electionName}').set(election.toJson());
        await _dbInstance
            .collection('ELECTIONS')
            .doc('${election.electionName}')
            .collection('ROLE')
            .doc(electionInfo[i].$1)
            .set({'roleName': electionInfo[i].$1});
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
          final ref = docRef.doc();
          await docRef.doc(ref.id).set(candidate.toJson(imageUrl, ref.id));
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
      final elections = await _dbInstance.collection('ELECTIONS').orderBy('startDate', descending: true).get();
      return elections.docs.map((e) => Election.fromJson(e.data())).toList();
    } catch (e) {
      log('$e');
      throw 'Error Fetching elections';
    }
  }

  // get active election
  Future<Election?> getActiveElection() async {
    try {
      final election = await _dbInstance.collection('ELECTIONS').where('isActive', isEqualTo: true).limit(1).get();
      if (election.docs.isEmpty) return null;
      return Election.fromJson(election.docs[0].data());
    } catch (e) {
      log('$e');
      throw 'Error occured';
    }
  }

  //get active election ** * check it oh when no election and list empty
  Future<List<(String, List<Candidate>)>> getActiveElectionInfo() async {
    List<(String, List<Candidate>)> electionData = [];
    try {
      final election = await _dbInstance.collection('ELECTIONS').where('isActive', isEqualTo: true).get();

      if (election.docs.isEmpty) return [];
      final roles = await election.docs[0].reference.collection('ROLE').get();
      log('${roles.docs}');
      for (var role in roles.docs) {
        final candidates = await role.reference.collection('CANDIDATES').get();

        final List<Candidate> arr = [];
        for (var candidate in candidates.docs) {
          log("${Candidate.fromJson(candidate.data())}");
          arr.add(Candidate.fromJson(candidate.data()));
        }
        electionData.add(((role.id), arr));
      }

      return electionData;
    } catch (e) {
      log('$e');
      throw 'Error occured while fetching election';
    }
  }

  //close elections
  Future<bool> closeElections(String electionName) async {
    try {
      await _dbInstance.collection('ELECTIONS').doc(electionName).update({'isActive': false});
      return true;
    } catch (e) {
      log('$e');
      throw 'Error occured while closing elections';
    }
  }

  Future<Candidate> getCandidate(String electionName, String role, String candidateId) async {
    try {
      final candidate = await _dbInstance
          .collection('ELECTIONS')
          .doc(electionName)
          .collection('ROLE')
          .doc(role)
          .collection('CANDIDATES')
          .doc(candidateId)
          .get();
      log(electionName + role + candidateId);
      log('${candidate.data()}');
      return Candidate.fromJson(candidate.data()!);
    } catch (e) {
      log('$e');
      throw 'could not get candidate';
    }
  }

  Future vote(String electionName, String role, String candidateId, String uid) async {
    try {
      final doc = await _dbInstance.collection('USERVOTEDROLES').doc(uid + electionName + role).get();
      if (!doc.exists) {
        final candidate = await getCandidate(electionName, role, candidateId);
        int val = candidate.votes;
        val++;
        await _dbInstance
            .collection('ELECTIONS')
            .doc(electionName)
            .collection('ROLE')
            .doc(role)
            .collection('CANDIDATES')
            .doc(candidateId)
            .update({'vote': val});
        //add the role and election voted for in a new collection.
        await _dbInstance.collection('USERVOTEDROLES').doc(uid + electionName + role).set({'candidateId': candidateId});
      }
    } catch (e) {
      log('$e');
      throw 'error occured while voting';
    }
  }

  Future<List<QueryDocumentSnapshot>> userVotes(String userId) async {
    try {
      final userVotes = await _dbInstance.collection('USERVOTEDROLES').get();
      return userVotes.docs.where((element) => element.id.contains(userId)).toList();
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future endElection() async {
    try {
      final ref = await _dbInstance.collection('ELECTIONS').where('isActive', isEqualTo: true).get();
      await ref.docs[0].reference.update({'isActive': false});
    } catch (e) {
      log('$e');
      throw 'Error occured';
    }
  }

  Future<DocumentReference<Map<String, dynamic>>> createSession(String uid, String sessionId) async {
    try {
      final docRef = _dbInstance.collection('USERS').doc(uid).collection('USERSESSION').doc();
      await docRef.set({'userId': uid, 'sessionId': sessionId});
      return docRef;
    } catch (e) {
      throw 'Error occured while creating session';
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getSession(String uid) async {
    try {
      final docRef = await _dbInstance.collection('USERS').doc(uid).collection('USERSESSION').get();
      if (docRef.docs.isNotEmpty) return docRef.docs.first;
      return null;
    } catch (e) {
      throw 'Error occured while creating session';
    }
  }

  Future deleteSession(String uid) async {
    try {
      final docRef = await _dbInstance.collection('USERS').doc(uid).collection('USERSESSION').limit(1).get();
      if (docRef.docs.isNotEmpty) {
        await docRef.docs.first.reference.delete();
      }
    } catch (e) {
      throw 'Failed to delete session';
    }
  }
}

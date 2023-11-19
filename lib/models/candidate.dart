import 'package:file_picker/file_picker.dart';

class Candidate {
  String? candidateName;
  String? cid;
  String? candidateDescription;
  final String? imageUrl;
  PlatformFile? file;
  int votes;
  bool isvoted;

  Candidate(
      {this.candidateDescription,
      this.votes = 0,
      this.isvoted = false,
      this.candidateName,
      this.file,
      this.cid,
      this.imageUrl});

  Map<String, dynamic> toJson(String url, String id) {
    return {
      'candidateName': candidateName,
      'candidateDescription': candidateDescription,
      'imageUrl': url,
      'vote': votes,
      'id': id,
    };
  }

  factory Candidate.fromJson(Map<String, dynamic> map) {
    return Candidate(
        candidateName: map['candidateName'],
        candidateDescription: map['candidateDescription'],
        imageUrl: map['imageUrl'],
        votes: map['vote'],
        cid: map['candidateId']);
  }
  @override
  String toString() {
    return '{candidateName: $candidateName, candidateDescription: $candidateDescription, candidateimagurl: $imageUrl, votes: $votes}';
  }
}

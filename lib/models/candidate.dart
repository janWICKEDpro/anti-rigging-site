import 'package:file_picker/file_picker.dart';

class Candidate {
  String? candidateName;
  String? candidateDescription;
  final String? imageUrl;
  PlatformFile? file;
  int votes;

  Candidate(
      {this.candidateDescription,
      this.votes = 0,
      this.candidateName,
      this.file,
      this.imageUrl});

  Map<String, dynamic> toJson(String url) {
    return {
      'candidateName': candidateName,
      'candidateDescription': candidateDescription,
      'imageUrl': url,
      'vote': votes
    };
  }

  factory Candidate.fromJson(Map<String, dynamic> map) {
    return Candidate(
        candidateName: map['candidateName'],
        candidateDescription: map['candidateDescription'],
        imageUrl: map['imageUrl'],
        votes: map['votes']);
  }
  @override
  String toString() {
    return '{candidateName: $candidateName, candidateDescription: $candidateDescription, candidateimagurl: $imageUrl, votes: $votes}';
  }
}

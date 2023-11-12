import 'dart:io';

class Candidate {
  final String? candidateName;
  final String? candidateDescription;
  final String? imageUrl;
  final File? file;

  const Candidate(
      {this.candidateDescription,
      this.candidateName,
      this.file,
      this.imageUrl});

  Map<String, dynamic> toJson() {
    return {
      'candidateName': candidateName,
      'candidateDescription': candidateDescription,
      'imageUrl': imageUrl
    };
  }

  factory Candidate.fromJson(Map<String, dynamic> map) {
    return Candidate(
        candidateName: map['candidateName'],
        candidateDescription: map['candidateDescription'],
        imageUrl: map['imageUrl']);
  }
}

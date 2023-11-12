import 'package:file_picker/file_picker.dart';

class Candidate {
  String? candidateName;
  String? candidateDescription;
  final String? imageUrl;
  PlatformFile? file;

  Candidate(
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

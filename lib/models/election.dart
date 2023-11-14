class Election {
  final String? electionName;
  final DateTime? endDate;
  final DateTime startDate;
  final bool? isActive;
  Election(
      {this.isActive,
      this.electionName,
      this.endDate,
      required this.startDate});
  Map<String, dynamic> toJson() {
    return {
      'electionName': electionName,
      'endDate': endDate,
      'startDate': startDate,
      'isActive': isActive,
    };
  }

  factory Election.fromJson(Map<String, dynamic> map) {
    return Election(
        startDate: map['startDate'].toDate(),
        endDate: map['endDate'].toDate(),
        isActive: map['isActive'],
        electionName: map['electionName']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'electionName: $electionName, isActive: $isActive, startDate: $startDate, endDate: $endDate';
  }
}

class SessionTimeModel {
  String week;
  String openTime;
  String closeTime;

  SessionTimeModel({this.closeTime, this.openTime, this.week});
  Map<String, dynamic> toMap() {
    return {
      'week': week,
      'openTime': openTime,
      'closeTime': closeTime,
    };
  }

  factory SessionTimeModel.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;

    return SessionTimeModel(
        week: firestore['week'],
        openTime: firestore['openTime'],
        closeTime: firestore['closeTime']);
  }
}

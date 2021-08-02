// enum Type {
//   user,
//   doctor
// }

class AuthType {
  String phone;
  String type;
  String userId;

  AuthType({this.phone, this.type, this.userId});

  Map<String, dynamic> toMap() {
    return {'phone': phone, 'type': type, 'userId': userId};
  }

  factory AuthType.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;

    return AuthType(
        phone: firestore['phone'],
        type: firestore['type'],
        userId: firestore['userId']);
  }
}

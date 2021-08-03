class UserProfile {
  String name;
  String email;
  String address;
  String profilePic;

  UserProfile({this.name, this.email, this.address, this.profilePic});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'profilePic': profilePic
    };
  }

  factory UserProfile.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;

    return UserProfile(
        name: firestore['name'],
        email: firestore['email'],
        address: firestore['address'],
        profilePic: firestore['priofilePic']);
  }
}

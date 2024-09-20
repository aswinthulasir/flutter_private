class UserCollection {
  final String userUID;
  final String name;
  final String email;
  final String upiID;
  final int phoneNumber;
  final String deviceToken;

  UserCollection({
    required this.userUID,
    required this.name,
    required this.email,
    required this.upiID,
    required this.phoneNumber,
    required this.deviceToken,
  });

  factory UserCollection.fromMap(Map<String, dynamic> data) {
    return UserCollection(
      userUID: data['userUID'],
      name: data['name'],
      email: data['email'],
      upiID: data['UPIID'],
      phoneNumber: data['phoneNumber'],
      deviceToken: data['deviceToken'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userUID': userUID,
      'name': name,
      'email': email,
      'upiID': upiID,
      'phoneNumber': phoneNumber,
      'deviceToken': deviceToken,
    };
  }
}

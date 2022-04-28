class UserModel {
  String? uid;
  String? email;
  String? fullName;

  // String? secondName;

  UserModel({this.uid, this.email, this.fullName});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      // secondName: map['secondName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      // 'secondName': secondName,
    };
  }
}

class UserModel {
  String? userId;
  String? email;
  String? firstName;
  String? lastName;

  UserModel({this.userId, this.email, this.firstName, this.lastName});

  factory UserModel.fromMap(map) {
    return UserModel(
      userId: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': userId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
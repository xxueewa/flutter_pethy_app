class PetModel {
  String? petId;
  String? userId;
  String? petName;
  String? birthDate;
  String? age;
  String? breed;
  String? pic;

  PetModel({this.petId, this.userId, this.petName, this.birthDate, this.age, this.breed, this.pic});

  factory PetModel.fromMap(map) {
    return PetModel(
      petId: map['petId'],
      userId: map['userId'],
      petName: map['petName'],
      birthDate: map['birthdate'],
      age: map['age'],
      breed: map['breed'],
      pic: map['pic'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'petId': petId,
      'userId': userId,
      'petName': petName,
      'birthdate': birthDate,
      'age': age,
      'breed': breed,
      'pic': pic
    };
  }
}
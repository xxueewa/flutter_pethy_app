import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicalRecordModel {
  String? recordId;
  String? petName;
  Timestamp? timeStamp;
  String? vetClinic;
  double? cost;
  String? userId;
  String? record;

  MedicalRecordModel({this.recordId, this.petName, this.timeStamp, this.vetClinic,
    this.cost, this.userId, this.record});

  factory MedicalRecordModel.fromMap(map) {
    return MedicalRecordModel(
      recordId: map['recordId'],
      petName: map['petId'],
      timeStamp: map['timeStamp'],
      vetClinic: map['vetClinic'],
      cost: map['cost'],
      userId: map['userId'],
      record: map['record'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recordId': recordId,
      'petId': petName,
      'timeStamp': timeStamp,
      'vetClinic': vetClinic,
      'cost': cost,
      'record': record
    };
  }
}
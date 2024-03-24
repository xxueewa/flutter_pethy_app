class MedicalRecordModel {
  String? recordId;
  String? petId;
  String? date;
  String? vetClinic;
  String? cost;
  String? record;
  String? additionalDetails;

  MedicalRecordModel({this.recordId, this.petId, this.date, this.vetClinic,
    this.cost, this.record, this.additionalDetails});

  factory MedicalRecordModel.fromMap(map) {
    return MedicalRecordModel(
      recordId: map['recordId'],
      petId: map['petId'],
      date: map['date'],
      vetClinic: map['vetClinic'],
      cost: map['cost'],
      record: map['record'],
      additionalDetails: map['additionalDetails'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recordId': recordId,
      'petId': petId,
      'date': date,
      'vetClinic': vetClinic,
      'cost': cost,
      'record': record,
      'additionalDetails': additionalDetails
    };
  }
}
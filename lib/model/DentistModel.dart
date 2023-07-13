import 'package:cloud_firestore/cloud_firestore.dart';
import '../shared/notification_helper.dart';

class DentistModel {
  final String? name;
  final String? email;
  final String? phone;
  final String? medicalID;
  final String? socialnumber;
  final String? clinicname;
  final String? clinicaddress;
  final String? uId;
  final String? docid;
  final String? profileimage;
  final String? devicetoken;

  DentistModel({
    this.name,
    this.email,
    this.phone,
    this.medicalID,
    this.socialnumber,
    this.clinicname,
    this.clinicaddress,
    this.uId,
    this.docid,
    this.profileimage,
    this.devicetoken,
  });

  factory DentistModel.fromdoc(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final dentist = DentistModel(
      name: doc.data()!['name'],
      email: doc.data()!['email'],
      phone: doc.data()!['phone'],
      medicalID: doc.data()!['medicalID'],
      socialnumber: doc.data()!['socialnumber'],
      clinicname: doc.data()!['clinicname'],
      clinicaddress: doc.data()!['clinicaddress'],
      uId: doc.data()!['uId'],
      docid: doc.id,
      profileimage: doc.data()!['profileimage'],
      devicetoken: doc.data()!['devicetoken'],
    );
    return dentist;
  }

  DentistModel copyWith(
          {String? name,
          String? email,
          String? phone,
          String? medicalID,
          String? socialnumber,
          String? clinicname,
          String? clinicaddress,
          String? uId,
          String? docid,
          String? profileimage,
          String? devicetoken}) =>
      DentistModel(
        name: name ?? this.name,
        email: email ?? this.email,
        profileimage: profileimage ?? this.profileimage,
        uId: uId ?? this.uId,
        medicalID: medicalID ?? this.medicalID,
        docid: docid ?? this.docid,
        socialnumber: socialnumber ?? this.socialnumber,
        clinicaddress: clinicaddress ?? this.clinicaddress,
        clinicname: clinicname ?? this.clinicname,
        phone: phone ?? this.phone,
        devicetoken: devicetoken ?? this.devicetoken,
      );
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone ?? '',
      'medicalID': medicalID ?? '',
      'socialnumber': socialnumber ?? '',
      'clinicname': clinicname ?? '',
      'clinicaddress': clinicaddress ?? '',
      'uId': uId,
      'docid': docid,
      'profileimage': profileimage ??
          'https://www.gentledental.com/sites/default/files/2020-03/generic-doctor-profile.jpg',
      'devicetoken': NotificationHelper.deviceToken,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String? dentistname;
  final String? uId;
  final String? docid;
  final String? profileimage;
  final String? patientname;
  final String? observation;
  final String?date;
  final String? time;


 ReportModel({
   this.dentistname,
   this.uId,
   this.docid,
   this.profileimage,
   this.patientname,
   this.observation,
   this.date,
   this.time
  });

  factory ReportModel.fromdoc(QueryDocumentSnapshot<Map<String, dynamic>> doc){

    final report =ReportModel(
      dentistname :doc.data()!['dentistname'],
      uId :doc.data()!['uId'],
      docid :doc.id,
      profileimage: doc.data()!['profileimage'],
      patientname: doc.data()!['patientname'],
      observation: doc.data()!['observation'],
    );
    return report;
  }

  Map<String, dynamic> toMap() {
    return {
      'dentistname': dentistname??'',
      'uId': uId??'',
      'docid':docid,
      'profileimage': profileimage??'',
      'patientname' : patientname??'',
      'observation' : observation??'',
      'date' : date,
      'time': time
    };
  }
}
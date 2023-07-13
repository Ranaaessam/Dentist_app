import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String? patientemail;
  final String? dentistname;
  final String? dentistemail;
  final String? status;
  final String? date;
  final String? time;
  final String? day;
  final String? docId;

  Appointment({
    this.patientemail,
    this.dentistname,
    this.dentistemail,
    this.status,
    this.date,
    this.time,
    this.day,
    this.docId,
  });

  factory Appointment.fromdoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final appointment = Appointment(
        patientemail: doc.data()['patientemail'],
        dentistname: doc.data()['dentistname'],
        dentistemail: doc.data()['dentistemail'],
        status: doc.data()['status'],
        date: doc.data()['date'],
        time: doc.data()['time'],
        day: doc.data()['day'],
        docId: doc.id);
    return appointment;
  }

  Map<String, dynamic> toMap() {
    return {
      'patientemail': patientemail,
      'dentistname': dentistname,
      'dentistemail': dentistemail,
      'status': status ?? 'Pending',
      'date': date,
      'time': time,
      'day': day,
      'docId': docId,
    };
  }
}

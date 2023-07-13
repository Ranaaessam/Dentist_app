import 'package:idental/model/DentistModel.dart';
import 'package:idental/model/ReportModel.dart';
import 'dart:async';
import 'dart:io';

abstract class AppStates {}

class AppInitalState extends AppStates {}

class AppChangeBottomNavBar extends AppStates {}

class GetDentistDataLoadingState extends AppStates {}

class GetDentistDataSuccessState extends AppStates {
  final DentistModel dentist;
  GetDentistDataSuccessState({required this.dentist});
}

class GetDentistDataErrorState extends AppStates {
  final String error;
  GetDentistDataErrorState(this.error);
}

class ProfileImagePickedSuccessState extends AppStates {}

class ProfileImagePickedErrorState extends AppStates {}

class UpdateDentistDataLoadingState extends AppStates {}

class UpdateDentistDataSuccessState extends AppStates {
  final DentistModel dentist;
  UpdateDentistDataSuccessState({required this.dentist});
}

class UpdateDentistDataErrorState extends AppStates {
  final String error;

  UpdateDentistDataErrorState(this.error);
}

class CreateReportLoadingState extends AppStates {}

class CreateReportSuccessState extends AppStates {
  final ReportModel report;
  CreateReportSuccessState({required this.report});
}

class CreateReportErrorState extends AppStates {
  final String error;
  CreateReportErrorState(this.error);
}

class GetReportSuccessState extends AppStates {
  List<Map<String, dynamic>> reports;
  GetReportSuccessState(this.reports);
}

class GetReportErrorState extends AppStates {
  final String error;
  GetReportErrorState(this.error);
}

class GetAppointmentsSuccessState extends AppStates {
  List<Map<String, dynamic>> Appointments;
  GetAppointmentsSuccessState(this.Appointments);
}

class GetApprovedAppsSuccessState extends AppStates {
  List<Map<String, dynamic>> Apps;

  GetApprovedAppsSuccessState(this.Apps);

  factory GetApprovedAppsSuccessState.empty() {
    return GetApprovedAppsSuccessState([]);
  }
}

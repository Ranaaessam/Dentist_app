abstract class RegisterStates {}
class RegisterInitalState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSucessState extends RegisterStates{}



class RegisterErrorState extends RegisterStates{
  final String error;

  RegisterErrorState(this.error);
}

class CreateDentistLoadingState extends RegisterStates{}
class CreateDentistSucessState extends RegisterStates{}



class CreateDentistErrorState extends RegisterStates{
  final String error;

  CreateDentistErrorState(this.error);
}


class ChangePasswordVisibilityState extends RegisterStates{}

class ChangeCheckBoxState extends RegisterStates{}

abstract class StateManger {}

//login
class LoginIntitalStates extends StateManger {}

class LoginLoadingStates extends StateManger {}

class LoginSuccessStates extends StateManger {
  final String message;
  LoginSuccessStates(this.message);
}

class LoginErrorStates extends StateManger {
  final String message;
  LoginErrorStates(this.message);
}

//signup
class SignUpIntitalStates extends StateManger {}

class SignUpLoadingStates extends StateManger {}

class SignUpSuccessStates extends StateManger {
  final String message;
  SignUpSuccessStates(this.message);
}

class SignUpErrorStates extends StateManger {
  final String message;
  SignUpErrorStates(this.message);
}
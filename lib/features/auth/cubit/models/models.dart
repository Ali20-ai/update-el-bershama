 class Usres{
  final String email;
  final String password;
  final String name;

  Usres({required this.email, required this.password, required this.name});




   Map<String, dynamic> toMap() {
    return {'email': email, 'password': password, 'name': name, };
  }
}
class Login{
 
  final String email;
  final String password;

  Login( this.email,  this.password);
  


  Map<String, dynamic> tologin() {
    return {'email': email, 'password': password,  };
  }
  
}
 
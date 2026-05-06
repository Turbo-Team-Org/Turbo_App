class SignInParams {
  final String email;
  final String password;
  String? displayName;

  SignInParams({required this.email, required this.password, this.displayName});
}

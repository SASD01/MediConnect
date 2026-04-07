class RegisterRequest {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phone;
  final String role; // 'patient'

  RegisterRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.role = 'patient',
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'role': role,
      };
}

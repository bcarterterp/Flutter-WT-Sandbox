import 'package:equatable/equatable.dart';

///This is where the object response from the Auth login call would be.
///Since we are not actually making any Auth calls, there is nothing here
class UserInfo extends Equatable {
  const UserInfo({
    required this.name,
    required this.email,
    required this.jwtToken,
  });

  final String name;
  final String email;
  final String jwtToken;

  @override
  List<Object?> get props => [name, email, jwtToken];
}

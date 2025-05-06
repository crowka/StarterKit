import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/current_user_data_model.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AppAutheticated extends AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationStart extends AuthenticationState {}

class UserLogoutState extends AuthenticationState {}

class SetUserData extends AuthenticationState {
  final CurrentUserDataModel currentUserData;
  SetUserData({this.currentUserData});
  @override
  List<Object> get props => [currentUserData];
}

class AuthenticationNotAuthenticated extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure({@required this.message});

  @override
  List<Object> get props => [message];
} 
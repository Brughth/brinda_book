import 'package:bloc/bloc.dart';
import 'package:brinda_book/auth/data/services/auth_service.dart';
import 'package:brinda_book/shared/utils/utils.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService service;
  AuthBloc({
    required this.service,
  }) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      try {
        emit(LoginLoading());
        await service.login(
          email: event.email,
          password: event.password,
        );
        emit(LoginSuccess());
      } catch (e) {
        emit(
          LoginFailure(
            message: Utils.extraErrorMessage(e),
          ),
        );
      }
    });

    on<RegisterEvent>((event, emit) async {
      try {
        emit(RegisterLoading());
        await service.register(
          email: event.email,
          password: event.password,
        );
        emit(RegisterSuccess());
      } catch (e) {
        emit(
          RegisterFailure(
            message: Utils.extraErrorMessage(e),
          ),
        );
      }
    });
  }
}

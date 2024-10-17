import 'package:auto_route/auto_route.dart';
import 'package:brinda_book/auth/business_logic/bloc/auth_bloc.dart';
import 'package:brinda_book/auth/data/services/auth_service.dart';
import 'package:brinda_book/shared/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late AuthBloc authBloc;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    authBloc = AuthBloc(
      service: AuthService(),
    );
    passwordController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is LoginLoading) {
            context.loaderOverlay.show();
          }

          if (state is LoginFailure) {
            context.loaderOverlay.hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }

          if (state is LoginSuccess) {
            context.loaderOverlay.hide();
            context.router.pushAndPopUntil(
              const ApplicationRoute(),
              predicate: (router) => false,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    helperText: "Email",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    helperText: "Password",
                  ),
                ),
                const SizedBox(height: 40),
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      authBloc.add(
                        LoginEvent(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    }
                  },
                  child: const Text("Login"),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    context.router.push(const RegisterRoute());
                  },
                  child: const Text("Register"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

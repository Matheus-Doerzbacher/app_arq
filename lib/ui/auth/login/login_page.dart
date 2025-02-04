import 'package:app_arq/config/dependencies.dart';
import 'package:app_arq/domain/dtos/credentials.dart';
import 'package:app_arq/domain/validators/credentials_validator.dart';
import 'package:app_arq/main.dart';
import 'package:app_arq/ui/auth/login/viewmodels/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:routefly/routefly.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final viewModel = injector.get<LoginViewModel>();
  final validator = CredentialsValidator();
  final credentials = Credentials();

  @override
  void initState() {
    viewModel.loginCommand.addListener(_listenable);
    super.initState();
  }

  void _listenable() {
    if (viewModel.loginCommand.isFailure) {
      final value = viewModel.loginCommand.value as FailureCommand;
      final snackBar = SnackBar(
        content: Text(value.error.toString()),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    viewModel.loginCommand.removeListener(_listenable);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 100),
            const SizedBox(height: 20),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: credentials.setEmail,
              validator: validator.byField(credentials, 'email'),
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: credentials.setPassword,
              validator: validator.byField(credentials, 'password'),
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),
            ListenableBuilder(
              listenable: viewModel.loginCommand,
              builder: (context, _) {
                return ElevatedButton(
                  onPressed: viewModel.loginCommand.isRunning
                      ? null
                      : () {
                          if (validator.validate(credentials).isValid) {
                            viewModel.loginCommand.execute(credentials);
                          }
                        },
                  child: viewModel.loginCommand.isRunning
                      ? SizedBox(
                          width: 25, // defina o tamanho desejado
                          height: 25,
                          child: CircularProgressIndicator(
                            strokeWidth: 3.0,
                          ),
                        )
                      : Text('Login'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

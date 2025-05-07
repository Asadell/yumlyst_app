import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/features/auth/data/provider/auth_provider.dart';
import 'package:recipe_app/features/auth/data/provider/static/auth_status.dart';
import 'package:recipe_app/routes/app_route.dart';
import 'package:recipe_app/style/colors/recipe_colors.dart';
import 'package:recipe_app/utils/toast_util.dart';
import 'package:recipe_app/widgets/primary_action_button.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250,
                ),
                Text("Login",
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _identifierController,
                  decoration: InputDecoration(
                    hintText: 'Identifier / Username',
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Passwordd',
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryActionButton(
                  text: 'Login',
                  onPressed: () => _tapToLogin(),
                  isLoading: context.watch<AuthProvider>().status ==
                      AuthStatus.authenticating,
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: [
                        const TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: "Register",
                          style: TextStyle(
                            color: RecipeColors.primary700.color,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.router.push(
                                  RegisterRoute(),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => context.router.push(
                    RegisterRoute(),
                  ),
                  child: const Text('back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _tapToLogin() async {
    final identifier = _identifierController.text;
    final password = _passwordController.text;

    // validasi gagal
    if (identifier.isEmpty && password.isEmpty) {
      ToastUtil.showWarning('Fill the identifier and password correctly');
      return;
    }

    final loginProvider = context.read<AuthProvider>();
    await loginProvider.login(identifier: identifier, password: password);

    switch (loginProvider.status) {
      case AuthStatus.authenticated:
        ToastUtil.showSuccess('Login successful!');
        context.router.replaceAll([MainRoute()]);
        break;
      default:
        ToastUtil.showWarning(loginProvider.errorMessage ?? "Login failed.");
    }
  }
}

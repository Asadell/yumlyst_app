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
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool _hasMinChars = false;
  bool _hasLetterAndNumber = false;
  bool _hasSpecialChar = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_validatePassword);
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _validatePassword() {
    final password = _passwordController.text;

    setState(() {
      _hasMinChars = password.length >= 8;
      _hasLetterAndNumber =
          RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$').hasMatch(password);
      _hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    });
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
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.router.pop(),
                    ),
                    Text(
                      "Register",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPasswordRequirement(
                        '8 characters minimum', _hasMinChars),
                    const SizedBox(height: 4),
                    _buildPasswordRequirement(
                        'At least has 1 letter and 1 number',
                        _hasLetterAndNumber),
                    const SizedBox(height: 4),
                    _buildPasswordRequirement(
                        'At least has 1 special character', _hasSpecialChar),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _confirmPassword,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                PrimaryActionButton(
                  text: 'Register',
                  onPressed: () => _tapToRegist(),
                  isLoading: context.watch<AuthProvider>().status ==
                      AuthStatus.creatingAccount,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _tapToRegist() async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPassword.text;

    // validasi gagal
    if (username.isEmpty && email.isEmpty && password.isEmpty) {
      ToastUtil.showWarning('Fill the input field correctly');
      return;
    }

    final registerProvider = context.read<AuthProvider>();
    await registerProvider.register(
      username: username,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    switch (registerProvider.status) {
      case AuthStatus.accountCreated:
        ToastUtil.showSuccess('Register successful!');
        context.router.pop();
        break;
      default:
        ToastUtil.showWarning(
            registerProvider.errorMessage ?? "Register failed.");
    }
  }

  Widget _buildPasswordRequirement(String text, bool isMet) {
    return Row(
      children: [
        Radio<bool>(
          value: true,
          groupValue: isMet ? true : null,
          onChanged: null,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isMet ? Colors.green : Colors.grey,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop_app_flutter/api/shop_api.dart';
import 'package:shop_app_flutter/models/auth_data.dart';
import 'package:shop_app_flutter/screens/shop_screen.dart';
import 'package:shop_app_flutter/util/token_manager.dart';

enum AuthAction { login, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // For toggling signup/login
  AuthAction authAction = AuthAction.login;

  // Show loader
  bool _isLoading = false;

  // Manipulating form
  // For example checking if form is valid or submitting
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void _toggleAuthAction() {
    if (authAction == AuthAction.login) {
      authAction = AuthAction.signup;
    } else {
      authAction = AuthAction.login;
    }
    // Rebuild the screen.
    setState(() {});
  }

  Future<void> _authenticate() async {
    // Show loader
    _isLoading = true;
    setState(() {});
    try {
      // Validate
      if (_formKey.currentState!.validate()) {
        // SignUp or SignIn
        late final AuthData authData;
        if (authAction == AuthAction.signup) {
          authData = await ShopApi.signup(
            email: emailController.text,
            password: passwordController.text,
          );
        } else {
          authData = await ShopApi.login(
            email: emailController.text,
            password: passwordController.text,
          );
        }
        // Save token
        await TokenManager.setToken(authData);

        // State object is currently in a tree, context is available
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(ShopScreen.routeName);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all inputs'),
          ),
        );
      }
    } catch (err) {
      print(err);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(err.toString()),
          ),
        );
      }
    } finally {
      _isLoading = false;
      setState(() {});
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Shop App"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                    ),
                    validator: (value) {
                      if (value != null &&
                          value.length > 6 &&
                          value.contains('@')) {
                        return null;
                      }
                      return 'Please provide valid email';
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: passwordController,
                    // Ensures we have obscure dots instead of characters
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                    ),
                    validator: (value) {
                      if (value != null && value.length >= 6) {
                        return null;
                      }
                      return 'Please enter valid password';
                    },
                  ),
                ),
                if (authAction == AuthAction.signup)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: confirmPasswordController,
                      // Ensures we have obscure dots instead of characters
                      obscureText: true,
                      // If authAction is login, we must also disable validation
                      autovalidateMode: authAction == AuthAction.login
                          ? AutovalidateMode.disabled
                          : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Confirm Password",
                      ),
                      validator: (value) {
                        if (value == passwordController.text) {
                          return null;
                        }
                        return 'Passwords should match';
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16.0,
                  ),
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () async {
                              _authenticate();
                            },
                            child: const Text('Submit'),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16.0,
                  ),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _toggleAuthAction();
                      },
                      child: Text(
                        authAction == AuthAction.signup
                            ? 'Login instead'
                            : 'Signup instead',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

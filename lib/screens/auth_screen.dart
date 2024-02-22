import 'package:flutter/material.dart';

// Enum type.
// An Enum, short for enumeration,
// is a type of data type in programming that consists of a set of named values.
// These named values, often referred to as members or enumerators, are constant and do not change.
enum AuthAction { login, signup }

class AuthScreen extends StatefulWidget {
  // Route name for this screen.
  // Static properties are attributes that belong to a class, rather than to an instance of that class.
  // Can be accessed with AuthScreen.routeName
  static const String routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  // For toggling signup/login (This enum type can be either login or signup)
  AuthAction authAction = AuthAction.login;

  // With TextEditingController we can access text from anywhere and clear textfields
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
    // Todo: Authenticate here
  }

  @override
  void dispose() {
    // disposing of TextEditingController is important to prevent memory leaks.
    // When you create a TextEditingController, it creates a link between the UI and the memory.
    // When you're done using the TextEditingController,
    // you should call dispose to break the link and free up the memory that it was using.
    // If you don't dispose of it, the link remains, and Flutter might update
    // the UI elements that are no longer visible, leading to unnecessary memory usage and
    // potential performance issues.
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Creates appBar
      appBar: AppBar(
        title: const Text("My Shop App"),
      ),
      // SingleChildScrollView ensures widget can scroll
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: passwordController,
                  // Ensures we have obscure dots instead of characters
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                ),
              ),
              if (authAction == AuthAction.signup)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: confirmPasswordController,
                    // Ensures we have obscure dots instead of characters
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Confirm Password",
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
    );
  }
}

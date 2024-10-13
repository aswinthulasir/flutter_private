import 'package:court_project/controllers/user_controller.dart';
import 'package:court_project/main.dart';
import 'package:court_project/screens/signup_screen.dart';
import 'package:court_project/utils/local_database.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final UserController _userController;
  late final TextEditingController _forgotEmailController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _userController = UserController();
    _forgotEmailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _forgotEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  const Text(
                    'Login to Court Project',
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text("Oops! forgot your password?"),
                      TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Reset Password"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "Enter your email address to reset your password",
                                        ),
                                        const SizedBox(height: 20),
                                        TextField(
                                          controller: _forgotEmailController,
                                          decoration: const InputDecoration(
                                            labelText: "Email Address",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel")),
                                      TextButton(
                                          onPressed: () {
                                            _userController
                                                .resetPassword(
                                              _forgotEmailController.text,
                                            )
                                                .then((_) {
                                              if (context.mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      "Password reset link sent to your email",
                                                    ),
                                                  ),
                                                );
                                              }
                                            }).catchError((err) {
                                              if (context.mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content:
                                                        Text(err.toString()),
                                                  ),
                                                );
                                              }
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Reset")),
                                    ],
                                  );
                                });
                          },
                          child: const Text("Reset")),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _userController
                              .signinWithEmailPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          )
                              .then((value) async {
                            final user = await _userController
                                .getUserDetails(value.user!.uid);

                            await LocalDatabase().saveUserData(
                              userId: user!.userUID,
                              email: user.email,
                              name: user.name,
                              phoneNumber: user.phoneNumber,
                              upiID: user.upiID,
                            );
                            await _userController
                                .updateDeviceToken(_emailController.text);

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const InitialiserScreen(),
                              ),
                            );
                          }).catchError((err) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(err.toString()),
                              ),
                            );
                          });
                        }
                      },
                      height: 60,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: MaterialButton(
                      onPressed: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ),
                        );
                      },
                      height: 60,
                      color: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

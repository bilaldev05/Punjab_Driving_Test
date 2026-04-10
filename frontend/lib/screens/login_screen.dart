import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app_theme.dart';
import '../services/api_service.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool isLoading = false;
  bool isLogin = true;

  void handleAuth() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();

    if (email.isEmpty || password.isEmpty) return;

    if (!isLogin && name.isEmpty) return;

    setState(() => isLoading = true);

    try {
      UserCredential userCredential;

      if (isLogin) {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        await ApiService.createUser({
          "uid": userCredential.user!.uid,
          "name": name,
          "email": email,
          "avatar": "",
          "totalScore": 0,
          "testsTaken": 0,
          "chapterProgress": []
        });
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              /// 🚗 LOGO SECTION
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x11000000),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    )
                  ],
                ),
                child: const Icon(
                  Icons.directions_car_rounded,
                  size: 45,
                  color: AppTheme.primary,
                ),
              ),

              const SizedBox(height: 20),

              /// TITLE
              Text(
                "Punjab Driving Test",
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              const SizedBox(height: 6),

              Text(
                isLogin
                    ? "Welcome back, sign in to continue"
                    : "Create your account to start",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              /// 📦 CARD FORM
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    if (!isLogin) ...[
                      _field(nameController, "Full Name"),
                      const SizedBox(height: 12),
                    ],

                    _field(emailController, "Email Address"),
                    const SizedBox(height: 12),

                    _field(passwordController, "Password", obscure: true),

                    const SizedBox(height: 20),

                    /// BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : handleAuth,
                        child: isLoading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(isLogin ? "Login" : "Create Account"),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// TOGGLE
              TextButton(
                onPressed: () => setState(() => isLogin = !isLogin),
                child: Text(
                  isLogin
                      ? "Don't have an account? Sign up"
                      : "Already have an account? Login",
                  style: const TextStyle(color: AppTheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String hint,
      {bool obscure = false}) {
    return TextField(
      controller: c,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }
}
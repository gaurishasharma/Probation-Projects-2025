import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool isLogin = true;
  bool loading = false;

  Future<void> handleAuth() async {
    setState(() => loading = true);
    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim(),
        );
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim(),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Authentication failed')),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  Future<void> signInWithGoogle() async {
    setState(() => loading = true);
    try {
      if (kIsWeb) {
        final GoogleAuthProvider provider = GoogleAuthProvider();
        await FirebaseAuth.instance.signInWithPopup(provider);
      } else {
        final GoogleSignIn googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        if (googleUser == null) return;

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In failed: $e')),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final grey = Colors.grey.shade900;
    final lightGrey = Colors.grey.shade200;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? grey : Colors.grey.shade100,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey : Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLogin ? 'Welcome Back' : 'Create Account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isLogin
                      ? 'Login to continue your journey'
                      : 'Join us and get started',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 32),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: isDark ? Colors.grey.shade800 : lightGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

              
                TextField(
                  controller: passController,
                  obscureText: true,
                  style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: isDark ? Colors.grey.shade800 : lightGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 28),

               
                loading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: handleAuth,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isDark ? Colors.grey.shade700 : Colors.grey.shade800,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            isLogin ? 'Login' : 'Sign Up',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => setState(() => isLogin = !isLogin),
                  child: Text(
                    isLogin
                        ? 'Create a new account'
                        : 'Already have an account? Login',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
                const SizedBox(height: 24),

                
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: Colors.grey.shade400, thickness: 0.5),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("or"),
                    ),
                    Expanded(
                      child: Divider(color: Colors.grey.shade400, thickness: 0.5),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: signInWithGoogle,
                    icon: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/4/4e/Gmail_Icon.png',
                      height: 20,
                    ),
                    label: const Text(
                      'Sign in with Google',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
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

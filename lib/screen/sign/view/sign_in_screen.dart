import 'package:budget_tracker_app/screen/pages/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? currentUser;

  Future<void> handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      setState(() {
        currentUser = googleUser;
      });
      if (googleUser != null) {
        // Navigate to the dashboard or main page
        Get.toNamed(
            GetPages.home); // Ensure you have defined this route in GetPages
      }
    } catch (error) {
      print('Error signing in: $error');
      Get.snackbar('Sign-In Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> handleSignOut() async {
    await googleSignIn.signOut();
    setState(() {
      currentUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    GetPages pages = Get.put(GetPages());
    return Scaffold(
      appBar: AppBar(title: Text('Google Sign-In')),
      body: Center(
        child: currentUser != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(currentUser!.photoUrl ?? ''),
                  ),
                  SizedBox(height: 10),
                  Text('Name: ${currentUser!.displayName}'),
                  Text('Email: ${currentUser!.email}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: handleSignOut,
                    child: Text('Sign Out'),
                  ),
                ],
              )
            : ElevatedButton(
                onPressed: handleSignIn,
                child: Text('Sign In with Google'),
              ),
      ),
    );
  }
}

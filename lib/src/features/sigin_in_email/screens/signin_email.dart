import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/widgets/button.dart';
import 'package:charity/src/shared/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 129),
            Text(
              'Sign in',
              style: TextStyle(
                color: const Color(0xFF272727),
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 32),
            CustomTextField(
              hintText: 'Email Address',
              controller: emailController,
            ),
            SizedBox(height: 16),
            ContinueButton(
              onPressed: () {
                String email = emailController.text.trim();
                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter your email')),
                  );
                  return;
                }
                Navigator.pushNamed(
                  context,
                  Routes.signInPassword,
                  arguments: email,
                );
              },
            ),

            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Dont have an Account ? ',
                  style: TextStyle(
                    color: const Color(0xFF272727),
                    fontSize: 12,

                    fontWeight: FontWeight.w400,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.createAcount,
                    );
                  },
                  child: Text(
                    'Create One',
                    style: TextStyle(
                      color: const Color(0xFF272727),
                      fontSize: 12,

                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 41),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: const BorderSide(width: 1, color: Color(0xFFDCDEDE)),
              ),
              onPressed: () {},
              child: ListTile(
                visualDensity: const VisualDensity(
                  vertical: VisualDensity.minimumDensity,
                ),
                leading: Image.asset('assets/icons/Apple svg.png'),
                title: Text(
                  'Continue With Apple',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF272727),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: const BorderSide(width: 1, color: Color(0xFFDCDEDE)),
              ),
              onPressed: () async {
                //  await signInWithGoogle(context: context);
              },
              child: ListTile(
                visualDensity: const VisualDensity(
                  vertical: VisualDensity.minimumDensity,
                ),
                leading: Image.asset('assets/icons/Google - png 0.png'),
                title: Text(
                  'Continue With Google',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF272727),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: const BorderSide(width: 1, color: Color(0xFFDCDEDE)),
              ),
              onPressed: () {},
              child: ListTile(
                visualDensity: const VisualDensity(
                  vertical: VisualDensity.minimumDensity,
                ),
                leading: Image.asset('assets/icons/Facebook - png 0.png'),
                title: Text(
                  'Continue With Facebook',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF272727),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* Future<void> signInWithGoogle({required BuildContext context}) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    User? user = userCredential.user;

    if (user != null) {
      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);

      final userExists = await userDoc.get();
      if (!userExists.exists) {
        await userDoc.set({
          'email': user.email,
          'name': user.displayName,
          'photoUrl': user.photoURL,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.layout,
        (route) => false,
      );
    }
  } catch (e) {
    print("Error signing in with Google: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to login, try again later")),
    );
  }
} */

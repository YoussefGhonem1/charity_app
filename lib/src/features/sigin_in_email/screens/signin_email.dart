import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/widgets/button.dart';
import 'package:charity/src/shared/widgets/text_form.dart';
import 'package:charity/src/shared/localization/app_translations.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppTranslations.of(context);
    final TextEditingController emailController = TextEditingController();
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 129),
            Text(
              t.translate('sign_in'),
              style: TextStyle(
                color: theme.textTheme.bodyLarge?.color,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 32),
            CustomTextField(
              hintText: t.translate('email_address'),
              controller: emailController,
            ),
            SizedBox(height: 16),
            ContinueButton(
              onPressed: () {
                String email = emailController.text.trim();
                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.translate('please_enter_email'))),
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
                  t.translate('dont_have_account'),
                  style: TextStyle(
                    color: theme.textTheme.bodyMedium?.color,
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
                    t.translate('create_one'),
                    style: TextStyle(
                      color: AppColors.primaryColor,
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
                side: BorderSide(
                  width: 1,
                  color: theme.dividerColor,
                ),
              ),
              onPressed: () {},
              child: ListTile(
                visualDensity: const VisualDensity(
                  vertical: VisualDensity.minimumDensity,
                ),
                leading: Image.asset('assets/icons/Apple svg.png'),
                title: Text(
                  t.translate('continue_with_apple'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge?.color,
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
                side: BorderSide(
                  width: 1,
                  color: theme.dividerColor,
                ),
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
                  t.translate('continue_with_google'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge?.color,
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
                side: BorderSide(
                  width: 1,
                  color: theme.dividerColor,
                ),
              ),
              onPressed: () {},
              child: ListTile(
                visualDensity: const VisualDensity(
                  vertical: VisualDensity.minimumDensity,
                ),
                leading: Image.asset('assets/icons/Facebook - png 0.png'),
                title: Text(
                  t.translate('continue_with_facebook'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge?.color,
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

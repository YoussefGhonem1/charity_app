import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 1,
                    color: const Color(0xFF4790EF),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 1,
                    color: const Color(0xFF4790EF),
                  ),
                ),
                labelText: 'Email Address',
                hintText: 'example@gmail.com',
              ),
            ),
            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signin_password');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFfe7277),
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
                  onTap: (){
                    Navigator.pushNamed(context, '/create_account');
                    },
               child:  Text(
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
                leading: Image.asset('assets/Apple svg.png'),
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
              onPressed: () {},
              child: ListTile(
                visualDensity: const VisualDensity(
                  vertical: VisualDensity.minimumDensity,
                ),
                leading: Image.asset('assets/Google - png 0.png'),
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
                leading: Image.asset('assets/Facebook - png 0.png'),
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

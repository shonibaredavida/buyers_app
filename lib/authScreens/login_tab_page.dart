import 'package:flutter/material.dart';
import 'package:trial/widgets/custom_text_field.dart';

class LoginTabPage extends StatefulWidget {
  const LoginTabPage({super.key});

  @override
  State<LoginTabPage> createState() => _LoginTabPageState();
}

class _LoginTabPageState extends State<LoginTabPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: const Color.fromARGB(91, 167, 156, 156),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.20,
              child: Image.asset("images/login.png"),
            ),
            const SizedBox(height: 30),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                      emailController, Icons.email, false, true, "Email"),
                  CustomTextField(
                      passwordController, Icons.lock, true, true, "Password"),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
              ),
              onPressed: () {},
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

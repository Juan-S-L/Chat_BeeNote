import 'package:chat_app/widgets/widgsts.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFED430),
      
      body: SafeArea(
          child: Center(
            
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  _Logo(),
              
                  // Formualrio
                  FormLogin(),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
      ),

    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(top: 20),
        child: const Column(
          children: [
            Image(image: AssetImage('assets/img/Logo.png'))
          ],
        ),
      ),
    );
  }
}
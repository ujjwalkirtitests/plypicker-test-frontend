import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend_mobile_app/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('');
  }

  Widget _headingText() {
    return Center(
      heightFactor: 5,
      child: Text(
        isLogin ? "Log In" : "Sign Up",
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
      ),
    );
  }

  Widget _entryField(
      String title, TextEditingController controller, Icon prefixIcon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: title,
      ),
    );
  }

  Widget _iconContainer(onPressHandler, IconData icon) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
        width: MediaQuery.sizeOf(context).width * 0.2,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.black),
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: LayoutBuilder(builder: (context, constraint) {
          return IconButton(
            onPressed: onPressHandler,
            icon: Icon(icon),
            iconSize: 34,
            color: Colors.black,
          );
        }));
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton() {
    return FractionallySizedBox(
      widthFactor: 0.85,
      child: ElevatedButton(
          onPressed: isLogin
              ? signInWithEmailAndPassword
              : createUserWithEmailAndPassword,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Text(
              isLogin ? 'LOG IN' : 'REGISTER',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          )),
    );
  }

  Widget _loginOrRegisterButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: !isLogin
          ? <Widget>[
              const Text('Already have an account?'),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = true;
                    });
                  },
                  child: const Text(
                    'Login!',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ))
            ]
          : <Widget>[
              const Text("Don't have an account?"),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = false;
                    });
                  },
                  child: const Text(
                    'Sign Up!',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ))
            ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              left: 1,
              top: 0,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.chevronLeft)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _headingText(),
                _entryField('Your Email', _controllerEmail,
                    const Icon(FontAwesomeIcons.envelope)),
                _entryField('Your Password', _controllerPassword,
                    const Icon(FontAwesomeIcons.lock)),
                _errorMessage(),
                _submitButton(),
                const SizedBox(
                  width: double.infinity,
                  height: 20,
                ),
                _loginOrRegisterButton(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Forgot Password'),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Click here',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ))
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.all(19.0),
                      child: Text(
                        'OR',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _iconContainer(() {}, FontAwesomeIcons.google),
                    _iconContainer(() {}, FontAwesomeIcons.apple),
                    _iconContainer(() {}, FontAwesomeIcons.facebook),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

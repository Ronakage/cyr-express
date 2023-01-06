import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/delivery.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/CustomColors.dart';

void main() {
  runApp(const CyrExpressApp());
}

class CyrExpressApp extends StatelessWidget {
  const CyrExpressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cyr Express',
      debugShowCheckedModeBanner: false,
      home: AuthentactionPage(title: 'Cyr Express'),
    );
  }
}

class AuthentactionPage extends StatefulWidget {
  const AuthentactionPage({super.key, required this.title});

  final String title;

  @override
  State<AuthentactionPage> createState() => _AuthentactionPageState();
}

class _AuthentactionPageState extends State<AuthentactionPage> {
  int _counter = 0;

  void _login() {
    setState(() {
      _counter++;
    });
  }

  void _register() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
    TODO :
    1 - replace sized boxes with padding
    2 -  make the view responsive
    2 - use api calls for login and register
    3 - create a register view
    4 - pass user model to navigator
    5 - have other views to navigate to (admin, staff, shop, driver, client)
    */
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Company name
              const AuthPageTitleWidget(),
              //E-mail Text Field
              const AuthPageEmailInputWidget(),
              //Password Text Field
              const AuthPagePasswordWidget(),
              const SizedBox(height: 30),
              //Login Button
              AuthPageLoginButton(),
              const SizedBox(height: 15),
              //Breaking Line
              const SizedBox(
                  height: 50, width: 100, child: Divider(color: Colors.grey)),
              const Text("Don't have an account yet? Register now!"),
              const SizedBox(height: 50),
              //Register Button
              AuthPageRegisterButton(),
              const SizedBox(height: 50),
              AuthPageDeliveryButton(),
            ],
          ),
        )),
      ),
    );
  }

  ElevatedButton AuthPageDeliveryButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.primaryColor,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        minimumSize: const Size(200, 50),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DeliveryPage()),
        );
      },
      child: const Text(
        "Go to Delivery Page",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  ElevatedButton AuthPageRegisterButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.primaryColor,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        minimumSize: const Size(200, 50),
      ),
      onPressed: _register,
      child: const Text(
        "Register",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  ElevatedButton AuthPageLoginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.primaryColor,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        minimumSize: const Size(200, 70),
      ),
      onPressed: _login,
      child: const Text(
        "Login",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class AuthPagePasswordWidget extends StatelessWidget {
  const AuthPagePasswordWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 25),
      child: SizedBox(
        width: 400,
        child: TextField(
            keyboardType: TextInputType.text,
            obscureText: true,
            maxLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.primaryColor),
              ),
              hintText: 'Password',
            )),
      ),
    );
  }
}

class AuthPageEmailInputWidget extends StatelessWidget {
  const AuthPageEmailInputWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 25, 0, 15),
      child: SizedBox(
        width: 400,
        child: TextField(
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.primaryColor),
              ),
              hintText: 'E-mail',
            )),
      ),
    );
  }
}

class AuthPageTitleWidget extends StatelessWidget {
  const AuthPageTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: GoogleFonts.poppins(
          fontSize: 50,
          fontWeight: FontWeight.w800,
          fontStyle: FontStyle.italic,
        ),
        child: SizedBox(
          width: 400,
          child: Center(
            child: TextLiquidFill(
              text: 'Cyr Express',
              waveColor: CustomColors.primaryColor,
              boxBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
              textStyle: const TextStyle(),
              boxHeight: 100.0,
            ),
          ),
        ));
  }
}

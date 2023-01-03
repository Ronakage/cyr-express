import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Center(
        child:
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Company name
              Text("Cyr Express", 
                  style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 59, 59, 61),
                  fontSize: 75,
                  fontWeight: FontWeight.w900,
                ), 
              ),
              const SizedBox(height: 50),
              //E-mail Text Field
              const SizedBox(
                width: 500,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: CustomColors.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustomColors.primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(100))
                    ),
                    hintText: 'E-mail',
                  )
                ),
              ),
              const SizedBox(height: 10),
              //Password Text Field
              const SizedBox(
                width: 500,
                child: TextField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: CustomColors.primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(100))
                    ),
                    hintText: 'Password',
                  )
                ),
              ),
              const SizedBox(height: 50),
              //Login Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                  ),
                  minimumSize: const Size(200, 70), 
                ),
                onPressed: _login,
                child: const Text("Login", style: TextStyle(fontSize: 20),),
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 50 ,width: 100 ,child: Divider(color: Colors.grey)),
              const Text("You don't have an account yet? Register now!"),
              const SizedBox(height: 50),
              //Register Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  minimumSize: const Size(200, 50), 
                ),
                onPressed: _register,
                child: const Text("Register", style: TextStyle(fontSize: 20),),
              ),
            ],
          ),
        )  
      ),
    );
  }
}

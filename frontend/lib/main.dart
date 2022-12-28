import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/CustomColors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cyr Express',
      // theme: ThemeData(
      //   primarySwatch: Color.fromARGB(255, 87, 62, 213),
      //   appBarTheme: Color.fromARGB(255, 87, 62, 213),
      // ),
      home: MyHomePage(title: 'Cyr Express'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        Column(
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
                    borderSide: BorderSide(color: CustomColors.primaryColor)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.primaryColor)
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
                    borderSide: BorderSide(color: CustomColors.primaryColor)
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
                    borderRadius: BorderRadius.circular(5.0),
                ),
                minimumSize: const Size(200, 70), 
              ),
              onPressed: _login,
              child: const Text("Login", style: TextStyle(fontSize: 20),),
            ),
            const SizedBox(height: 15),
            const SizedBox(width: 100 ,child: Divider(color: Colors.grey)),
            const Text("You don't have an account yet? Register now!"),
            const SizedBox(height: 15),
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
        )  
      ),
    );
  }
}

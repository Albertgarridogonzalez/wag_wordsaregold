import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _currentLogo = 'assets/logo2.png';
  Color _currentColor = const Color.fromARGB(255, 188, 148, 36);

  void _toggleTheme() {
    setState(() {
      if (_currentLogo == 'assets/logo2.png') {
        _currentLogo = 'assets/logo.png';
        _currentColor = const Color.fromARGB(255, 91, 42, 134);
      } else {
        _currentLogo = 'assets/logo2.png';
        _currentColor = const Color.fromARGB(255, 188, 148, 36);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    _currentLogo,
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'WAG',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      color: _currentColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Words Are Gold',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'User',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(_currentColor),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentColor,
                    ),
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(_currentColor),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/google_logo.png',
                            height: 20.0,
                          ),
                          const SizedBox(width: 10.0),
                          const Text(
                            'Sign in with Google',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(
                Icons.autorenew,
                size: 30,
                color: _currentColor,
              ),
              onPressed: _toggleTheme,
            ),
          ),
        ],
      ),
    );
  }
}

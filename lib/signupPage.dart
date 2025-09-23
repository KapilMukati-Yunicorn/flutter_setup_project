import 'package:flutter/material.dart';

void main() {
  runApp(LocalAuthApp());
}

class LocalAuthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Auth Demo',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

// Simple in-memory "database"
final Map<String, String> users = {};

/// ✅ Login Page
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (users.containsKey(_email) && users[_email] == _password) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage(email: _email)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid email or password")),
        );
      }
    }
  }

  void _goToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SignupPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) =>
                value == null || !value.contains("@")
                    ? "Enter a valid email"
                    : null,
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) =>
                value == null || value.length < 6
                    ? "Password must be 6+ chars"
                    : null,
                onSaved: (value) => _password = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _login, child: Text("Login")),
              TextButton(onPressed: _goToSignup, child: Text("Create Account")),
            ],
          ),
        ),
      ),
    );
  }
}

/// ✅ Signup Page
class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _signup() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (users.containsKey(_email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User already exists")),
        );
      } else {
        users[_email] = _password;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup successful! Please login.")),
        );
        Navigator.pop(context); // go back to login
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) =>
                value == null || !value.contains("@")
                    ? "Enter a valid email"
                    : null,
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) =>
                value == null || value.length < 6
                    ? "Password must be 6+ chars"
                    : null,
                onSaved: (value) => _password = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _signup, child: Text("Sign Up")),
            ],
          ),
        ),
      ),
    );
  }
}

/// ✅ Home Page (after login)
class HomePage extends StatelessWidget {
  final String email;
  HomePage({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Text("Hello, $email"),
      ),
    );
  }
}

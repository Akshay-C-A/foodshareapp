import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodshareapp/donerhomepage.dart';
import 'package:foodshareapp/ngohomepage.dart';
import 'package:foodshareapp/ohhomepage.dart';


class DonorLoginPage extends StatefulWidget {
  @override
  _DonorLoginPageState createState() => _DonorLoginPageState();
}

class _DonorLoginPageState extends State<DonorLoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                 // Adding space between the top and the 'Login' heading
                Text(
                  'Donor Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45.0, // Slightly larger font size
                    fontWeight: FontWeight.bold, // Bold font weight
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email id',
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 10.0), // Adding space between the button and the new section
                Text(
                  'Not a member? Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue, // Set the text color to blue
                  ),
                ),
                SizedBox(height: 50.0),

    IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: _goBack,
    ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    String username = _emailController.text;
    String password = _passwordController.text;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DonorHomePage()),
    );
    // Validate username and password
    // For demonstration purposes, just print them
    print('Username: $username');
    print('Password: $password');
    // You can add authentication logic here
  }

  
    void _goBack() {
  Navigator.pop(context);
}

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

//---------------------------------------------------------------------------------------------------------------------------

class NGOLoginPage extends StatefulWidget {
  @override
  State<NGOLoginPage> createState() => _NGOLoginPageState();
}

class _NGOLoginPageState extends State<NGOLoginPage> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                 // Adding space between the top and the 'Login' heading
                Text(
                  'NGO Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45.0, // Slightly larger font size
                    fontWeight: FontWeight.bold, // Bold font weight
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email id',
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 10.0), // Adding space between the button and the new section
                Text(
                  'Not a member? Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue, // Set the text color to blue
                  ),
                ),
                SizedBox(height: 50.0),
                IconButton(
  icon: Icon(Icons.arrow_back),
  onPressed: _goBack,
  
),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    String username = _emailController.text;
    String password = _passwordController.text;
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NGOHomePage()),
            );
    // Validate username and password
    // For demonstration purposes, just print them
    print('Username: $username');
    print('Password: $password');
   
    // You can add authentication logic here
  }

  void _goBack() {
  Navigator.pop(context);
}

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  
}

//--------------------------------------------------------------------------------------------------------------------  

class OrganicHarvesterLoginPage extends StatefulWidget {
  @override
  _OrganicHarvesterLoginPageState createState() => _OrganicHarvesterLoginPageState();
}

class _OrganicHarvesterLoginPageState extends State<OrganicHarvesterLoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                 // Adding space between the top and the 'Login' heading
                Text(
                  'Organic Harvester Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45.0, // Slightly larger font size
                    fontWeight: FontWeight.bold, // Bold font weight
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email id',
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 10.0), // Adding space between the button and the new section
                Text(
                  'Not a member? Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue, // Set the text color to blue
                  ),
                ),
                SizedBox(height: 50.0),
                IconButton(
  icon: Icon(Icons.arrow_back),
  onPressed: _goBack,
),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    String username = _emailController.text;
    String password = _passwordController.text;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrganicHarvesterHomePage()),
    );
    // Validate username and password
    // For demonstration purposes, just print them
    print('Username: $username');
    print('Password: $password');
   
    // You can add authentication logic here
  }

void _goBack() {
  Navigator.pop(context);
}

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}


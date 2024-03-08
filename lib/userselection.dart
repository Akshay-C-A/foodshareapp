import 'package:flutter/material.dart';
import 'package:foodshareapp/login.dart';

class UserTypeSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center( child: Text(' Welcome to FoodShare')),
        backgroundColor: Colors.white, // Appbar color
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                Text(
                    'Select User Type',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.0, // Slightly larger font size
                      fontWeight: FontWeight.bold, // Bold font weight
                    ),
                  ),
                SizedBox(height: 40.0,),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle Donor button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DonorLoginPage()),
                  );
                },
                icon: Icon(Icons.person),
                label: Text('Donor'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 215, 224, 232), // Donor button color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 40.0),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle NGO button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NGOLoginPage()),
                  );                
                },
                icon: Icon(Icons.people),
                label: Text('NGO'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 215, 224, 232), // NGO button color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 40.0),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle Organic Harvester button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrganicHarvesterLoginPage()),
                  );
                },
                icon: Icon(Icons.eco),
                label: Text('Organic Harvester'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 215, 224, 232), // Organic Harvester button color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodshareapp/services/firestore.dart';
import 'package:intl/intl.dart';

class DonorHomePage extends StatefulWidget {
  @override
  _DonorHomePageState createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage> {
  final FirestoreService firestoreService = FirestoreService();

  final formKey = GlobalKey<FormState>();
  String foodName = '',
      foodQuantity = '',
      foodExpiry = '',
      address = '',
      contact = '';

  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _foodQuantityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  void _showForm() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Donate Food'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Food Name',
                    ),
                    controller: _foodNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the name of the food';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      foodName = value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Food Quantity',
                    ),
                    controller: _foodQuantityController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the quantity of the food';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      foodQuantity = value!;
                    },
                  ),

                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Food Expiry Date',
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(
                          new FocusNode()); // to prevent opening default keyboard
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        foodExpiry =
                            DateFormat('dd/MM/yyyy').format(pickedDate);
                        _expiryDateController.text =
                            foodExpiry; // assuming you have a controller for this field
                      }
                    },
                    controller:
                        _expiryDateController, // make sure to define this controller
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the expiry date of the food';
                      }
                      return null;
                    },
                  ),

                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Address for Food Collection',
                    ),
                    controller: _addressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the address for food collection';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      address = value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Contact Details',
                    ),
                    controller: _contactController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your contact details';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      contact = value!;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  //to add to donations collection
                  firestoreService.addDonation(
                    foodName: foodName,
                    foodQuantity: foodQuantity,
                    foodExpiry: foodExpiry,
                    address: address,
                    contact: contact,
                  );

                        // Clear the form after submission
                  _foodNameController.clear(); // Clear food name text field
                  _foodQuantityController.clear(); // Clear food quantity text field
                  _expiryDateController.clear(); // Clear expiry date text field
                  _addressController.clear(); // Clear address text field
                  _contactController.clear(); // Clear contact text field

                  // TODO: Send the data to the backend or database
                  print('Food Name: $foodName');
                  print('Food Quantity: $foodQuantity');
                  print('Food Expiry Date: $foodExpiry');
                  print('Address for Food Collection: $address');
                  print('Contact Details: $contact');
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Thank you for your donation!'),
                    ),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    PostDonationPage(),
    DonationHistoryPage(),
    RewardPointsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor Home'),
        backgroundColor: Color.fromARGB(255, 195, 202, 243),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: _showForm,
        child: Icon(Icons.post_add),
        ),

        
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Donation History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'View Rewards',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }


}

class PostDonationPage extends StatefulWidget {
  @override
  State<PostDonationPage> createState() => _PostDonationPageState();
}

class _PostDonationPageState extends State<PostDonationPage> {
  final FirestoreService firestoreService= FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getDonationsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> donations = snapshot.data!.docs;

return ListView.builder(
  itemCount: donations.length,
  itemBuilder: (context, index) {
    DocumentSnapshot donation = donations[index];
    Map<String, dynamic> data = donation.data() as Map<String, dynamic>;

    // Extract donation details
    String foodName = data['foodName'];
    String foodQuantity = data['foodQuantity'];
    String foodExpiry = data['foodExpiry'];
    String address = data['address'];
    String contact = data['contact'];

    //Build a card for each donation
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(foodName),
        subtitle: Text('Quantity: $foodQuantity\nExpiry: $foodExpiry\nAddress: $address\nContact: $contact'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // Show a confirmation dialog before deleting the donation
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Confirm Delete'),
                content: Text('Are you sure you want to delete this donation?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Delete the donation from Firestore
                      firestoreService.deleteDonation(donation.id);

                      // Close the dialog
                      Navigator.of(context).pop();
                    },
                    child: Text('Delete'),
                  ),
                ],
              ),
            );
          },
        ),
        onTap: () {
          // Navigate to a screen for updating the donation (if needed)
        },
      ),
    );
  },
);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class DonationHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Donation History Page'),
    );
  }
}

class RewardPointsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Reward Points Page'),
    );
  }
}

//----------------------------------------------------------------



//----------------------------------------------------------------


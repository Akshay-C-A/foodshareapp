import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodshareapp/services/firestore.dart';

class NGOHomePage extends StatefulWidget {
  @override
  _NGOHomePageState createState() => _NGOHomePageState();
}

class _NGOHomePageState extends State<NGOHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    DonatedFoodPage(),
    CartPage(),
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
        title: Text('NGO Home'),
        backgroundColor: Color.fromARGB(255, 195, 202, 243),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'View Donated Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'View Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class DonatedFoodPage extends StatefulWidget {
  @override
  State<DonatedFoodPage> createState() => _DonatedFoodPageState();
}

class _DonatedFoodPageState extends State<DonatedFoodPage> {
  FirestoreService firestoreService = FirestoreService();

  // Function to add donation to cart
  void addToCart(DocumentSnapshot donation) {
    firestoreService.addtoCart(
      foodName: donation['foodName'],
      foodQuantity: donation['foodQuantity'],
      foodExpiry: donation['foodExpiry'],
      address: donation['address'],
      contact: donation['contact'],
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added to Cart')),
    );
  }

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
                Map<String, dynamic> data =
                    donation.data() as Map<String, dynamic>;

                // Extract donation details
                String foodName = data['foodName'];
                String foodQuantity = data['foodQuantity'];
                String foodExpiry = data['foodExpiry'];
                String address = data['address'];
                String contact = data['contact'];

                return Card(
                  elevation: 2,
                  margin: EdgeInsets.fromLTRB(15.0, 7.0, 15.0, 7.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(foodName),
                          subtitle: Text(
                              'Quantity: $foodQuantity\nExpiry: $foodExpiry\nAddress: $address\nContact: $contact'),
                          onTap: () {
                            // Navigate to a screen for updating the donation (if needed)
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                addToCart(donation);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.amberAccent),
                              ),
                              child: Text('Add to Cart'),
                            ),
                          ],
                        ),
                      ],
                    ),
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

class CartPage extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getCartItemsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> cartItems = snapshot.data!.docs;

          if (cartItems.isEmpty) {
            return Center(
              child: Text('Your cart is empty.'),
            );
          }

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index].data() as Map<String, dynamic>;

              // Extract item details
              String foodName = cartItem['foodName'];
              int foodQuantity = int.tryParse(cartItem['foodQuantity'].toString()) ?? 0;
              String foodExpiry = cartItem['foodExpiry'];
              String address = cartItem['address'];
              String contact = cartItem['contact'];

              // Function to delete an item from the cart
              void deleteItem() {
                firestoreService.deleteCartItem(cartItems[index].id);
              }

              // Function to increment item quantity
              void incrementQuantity() {
                firestoreService.updateCartItemQuantity(
                  cartItems[index].id,
                  foodQuantity + 1,
                );
              }

              // Function to decrement item quantity
              void decrementQuantity() {
                if (foodQuantity > 1) {
                  firestoreService.updateCartItemQuantity(
                    cartItems[index].id,
                    foodQuantity - 1,
                  );
                }
              }

              return Card(
                elevation: 2,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(foodName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: $foodQuantity'),
                      Text('Expiry: $foodExpiry'),
                      Text('Address: $address'),
                      Text('Contact: $contact'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: incrementQuantity,
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: decrementQuantity,
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: deleteItem,
                      ),
                    ],
                  ),
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
    );
  }
}



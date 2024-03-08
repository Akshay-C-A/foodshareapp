// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:foodshareapp/ngohomepage.dart';
// import 'package:foodshareapp/services/firestore.dart';

// class OrganicHarvesterHomePage extends StatefulWidget {
//   @override
//   _OrganicHarvesterHomePageState createState() => _OrganicHarvesterHomePageState();
// }

// class _OrganicHarvesterHomePageState extends State<OrganicHarvesterHomePage> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Organic Harvester Home'),
//         backgroundColor: Color.fromARGB(255, 195, 202, 243),
//       ),
//       body:
//        _selectedIndex == 0 ? ExpiredFoodPage() : CartPage(),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.food_bank),
//             label: 'View Expired Food',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart),
//             label: 'View Cart',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// // class ExpiredFoodPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Text('No expired food available.'),
// //     );
// //   }
// // }

// class ExpiredFoodPage extends StatelessWidget {
//   final FirestoreService firestoreService = FirestoreService();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: firestoreService.getDonationsStream(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           List<QueryDocumentSnapshot> allDonations = snapshot.data!.docs;

//           List<QueryDocumentSnapshot> expiredDonations = allDonations.where((donation) {
//             dynamic foodExpiryData = donation['foodExpiry'];
//             DateTime? foodExpiryDate; // Declare as nullable DateTime

//             if (foodExpiryData is Timestamp) {
//               Timestamp foodExpiryTimestamp = foodExpiryData;
//               foodExpiryDate = foodExpiryTimestamp.toDate();
//             } else {
//               // Handle the case where foodExpiryData is not a Timestamp
//               // For example, you can set foodExpiryDate to null or a default value
//               // foodExpiryDate = DateTime.now(); // or some other default value
//             }

//             // Ensure foodExpiryDate is not null before using it
//             return foodExpiryDate != null && foodExpiryDate.isBefore(DateTime.now());
//           }).toList();

//           if (expiredDonations.isEmpty) {
//             return Center(
//               child: Text('No expired food available.'),
//             );
//           }

//           return ListView.builder(
//             itemCount: expiredDonations.length,
//             itemBuilder: (context, index) {
//               final expiredDonation = expiredDonations[index].data() as Map<String, dynamic>;

//               // Extract donation details
//               String foodName = expiredDonation['foodName'];
//               String foodExpiry = expiredDonation['foodExpiry'];

//               return Card(
//                 elevation: 2,
//                 margin: EdgeInsets.all(8),
//                 child: ListTile(
//                   title: Text(foodName),
//                   subtitle: Text('Expired Date: $foodExpiry'),
//                 ),
//               );
//             },
//           );
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Text('Error: ${snapshot.error}'),
//           );
//         } else {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }
// }
//-----------------------------------------------------------------------------------------

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodshareapp/ngohomepage.dart';
import 'package:foodshareapp/services/firestore.dart';

class OrganicHarvesterHomePage extends StatefulWidget {
  @override
  _OrganicHarvesterHomePageState createState() => _OrganicHarvesterHomePageState();
}

class _OrganicHarvesterHomePageState extends State<OrganicHarvesterHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organic Harvester Home'),
        backgroundColor: Color.fromARGB(255, 195, 202, 243),
      ),
      body: _selectedIndex == 0 ? ExpiredFoodPage() : CartPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'View Expired Food',
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

class ExpiredFoodPage extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getDonationsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> allDonations = snapshot.data!.docs;

          List<QueryDocumentSnapshot> expiredDonations = allDonations.where((donation) {
            dynamic foodExpiryData = donation['foodExpiry'];
            print(donation['foodExpiry']);
            DateTime? foodExpiryDate; // Declare as nullable DateTime

            if (foodExpiryData is Timestamp) {
              Timestamp foodExpiryTimestamp = foodExpiryData;
              foodExpiryDate = foodExpiryTimestamp.toDate();
            } else {
              // Handle the case where foodExpiryData is not a Timestamp
              // For example, you can set foodExpiryDate to null or a default value
              // foodExpiryDate = DateTime.now(); // or some other default value
            }

            // Ensure foodExpiryDate is not null before using it
            return foodExpiryDate != null && foodExpiryDate.isBefore(DateTime.now());
          }).toList();

          if (expiredDonations.isEmpty) {
            return Center(
              child: Text('No expired food available.'),
            );
          }

          return ListView.builder(
            itemCount: expiredDonations.length,
            itemBuilder: (context, index) {
              final expiredDonation = expiredDonations[index].data() as Map<String, dynamic>;

              // Extract donation details
              String foodName = expiredDonation['foodName'];
              String foodExpiry = expiredDonation['foodExpiry'];

              return Card(
                elevation: 2,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(foodName),
                  subtitle: Text('Expired Date: $foodExpiry'),
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

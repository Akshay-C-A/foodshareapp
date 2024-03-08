import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // get collection of donations
  final CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');

  // add a donation
  Future<void> addDonation({
    required String foodName,
    required String foodQuantity,
    required String foodExpiry,
    required String address,
    required String contact,
  }) {
    return donations.add({
      'foodName': foodName,
      'foodQuantity': foodQuantity,
      'foodExpiry': foodExpiry,
      'address': address,
      'contact': contact,
      'timestamp': Timestamp.now(),
    });
  }

  // read all the donations
  Stream<QuerySnapshot> getDonationsStream() {
    final donationsStream =
        donations.orderBy('timestamp', descending: true).snapshots();

    return donationsStream;
  }

  // update a donation given an id
  // You can implement this if needed

  // delete a donation given an id
  Future<void> deleteDonation(String donationId) {
    return donations.doc(donationId).delete();
  }
  // You can implement this if needed

  // get collection of donations
  final CollectionReference carts =
      FirebaseFirestore.instance.collection('cart_items');

  // add a donation
  Future<void> addtoCart({
    required String foodName,
    required String foodQuantity,
    required String foodExpiry,
    required String address,
    required String contact,
  }) {
    return carts.add({
      'foodName': foodName,
      'foodQuantity': foodQuantity,
      'foodExpiry': foodExpiry,
      'address': address,
      'contact': contact,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getCartItemsStream() {
    final cartItemsStream =
        carts.orderBy('timestamp', descending: true).snapshots();

    return cartItemsStream;
  }
// Delete a cart item
  Future<void> deleteCartItem(String itemId) {
    return carts.doc(itemId).delete();
  }

  // Update the quantity of a cart item
  Future<void> updateCartItemQuantity(String itemId, int newQuantity) {
    return carts.doc(itemId).update({
      'foodQuantity': newQuantity,
    });
  }

Stream<QuerySnapshot> getExpiredFoodStream() {
  // Get a reference to the Firestore collection containing donations
  final CollectionReference donationsCollection = FirebaseFirestore.instance.collection('donations');

  // Get the current date
  final DateTime currentDate = DateTime.now();

  // Construct a query to fetch expired food items from donations
  Query expiredFoodQuery = donationsCollection.where('foodExpiry', isLessThan: Timestamp.fromDate(currentDate));

  // Return the stream of expired food items
  return expiredFoodQuery.snapshots();
}

}

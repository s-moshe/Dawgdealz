import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:navigation/models/item.dart';

class ItemProvider extends ChangeNotifier {
  List<Item> _items = [];
  bool _isLoading = false;

  List<Item> get items => _items;
  bool get isLoading => _isLoading;

  ItemProvider() {
    // Fetch items on initialization
    fetchItems();
  }

  Future<void> fetchItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('items')
          .orderBy('timestamp', descending: true)
          .get();
      _items = querySnapshot.docs
          .map((doc) => Item.fromMap(doc.data()))
          .toList();
    } catch (error) {
      debugPrint('Error fetching items: $error');
      _items = []; // Fallback to an empty list on error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

Future<void> deleteItem(String itemId) async {
   _isLoading = true;
    notifyListeners();
  try {
    // Reference to the specific document
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('items')
        .doc(itemId); // Document ID to delete
    // Delete the document
    await docRef.delete();
    _items.removeWhere((item)=>item.id==itemId);
    debugPrint("Item deleted successfully");
  } catch (e) {
    debugPrint("Error deleting item: $e");
  }finally {
      _isLoading = false;
      notifyListeners();
  }
}

}


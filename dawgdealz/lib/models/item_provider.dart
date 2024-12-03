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
          .collection('Items')
          .orderBy('timestamp', descending: true)
          .get();
      _items = querySnapshot.docs
          .map((doc) => Item.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (error) {
      print('Error fetching items: $error');
      _items = []; // Fallback to an empty list on error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

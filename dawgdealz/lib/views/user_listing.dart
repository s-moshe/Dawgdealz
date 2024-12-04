import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:navigation/models/item_provider.dart';
import 'package:provider/provider.dart';

class UserListing extends StatefulWidget {
  const UserListing({super.key});

  @override
  UserItemList createState() => UserItemList();
}

class UserItemList extends State<UserListing> {
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  
  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    final items = itemProvider.items.where((item) => item.userId == userId).toList();
    
    return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          title: Text(
            '${items[index].name}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Listed on: ${items[index].listedDate}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () {
              itemProvider.deleteItem(items[index].id);
            },
          ),
        ),
      ),
    );
  },
);
  }
}

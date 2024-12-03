import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:navigation/models/item.dart';
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
        return ListTile(
          title: Text('${items[index].name} listed on: ${items[index].listedDate}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
             itemProvider.deleteItem(items[index].id);
            },
          ),
        );
      },
    );
  }
}

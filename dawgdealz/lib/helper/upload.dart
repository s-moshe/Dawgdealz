import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadItemImageForUser(File file)async{
    try{
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final storageRef = FirebaseStorage.instance.ref("/itemImages");
      final timestamp = DateTime.now().microsecondsSinceEpoch;
      final fileName = file.path.split("/").last;
      final uploadRef = storageRef.child("$userId/$timestamp-$fileName");
      await uploadRef.putFile(file);
       return await uploadRef.getDownloadURL(); 
    }catch(e){
      print(e);
    }
    return null;
  }

Future<void> saveItemData(String name, String description, String price, String category, String condition, List<String> imageUrls) async {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final itemData = {
    'name': name,
    'description': description,
    'price': price,
    'category': category,
    'condition': condition,
    'images': imageUrls,
    'userId': userId,
    'timestamp': DateTime.now().toIso8601String(),
  };

  // Save the data in Firestore under "Items" collection
 DocumentReference docRef = await FirebaseFirestore.instance.collection('Items').add(itemData);
 
}
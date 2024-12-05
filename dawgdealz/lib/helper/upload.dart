import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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
      debugPrint(e as String?);
    }
    return null;
  }

Future<void> saveItemData(String name, String description, String price, String category, String condition, List<String> imageUrls) async {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final itemData = {
    'id': '',
    'name': name,
    'description': description,
    'price': price,
    'category': category,
    'condition': condition,
    'images': imageUrls,
    'userId': userId,
    'timestamp': DateTime.now().toIso8601String(),
  };

 final firestore = FirebaseFirestore.instance;

  // Add to "items" collection (for homepage)
  final itemRef = await firestore.collection("items").add(itemData);
 itemRef.update({'id':itemRef.id});
}


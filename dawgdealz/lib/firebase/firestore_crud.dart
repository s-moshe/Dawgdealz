import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class FirestoreCrud {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // Users


  // Add a new user with default profile values
  Future<void> addDummyUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'name': 'Default Name',
        'bio': 'Default Bio',
        'email': 'default',
        'major': 'Undeclared',
        'gradDate': 2025,
        'preferredMeetupSpots': ['Red Square', 'Quad', 'Other'],
      });
      debugPrint('User added successfully!');
    } catch (e) {
      debugPrint('Error adding user: $e');
    }
  }


  // Update user profile
  Future<void> updateUserProfile(String userId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('users').doc(userId).update(updatedData);
      debugPrint('User profile updated successfully!');
    } catch (e) {
      debugPrint('Error updating user profile: $e');
    }
  }


  // Read user profile
  Future<DocumentSnapshot> getUserProfile(String userId) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(userId).get();
      debugPrint('User profile fetched successfully!');
      return snapshot;
    } catch (e) {
      debugPrint('Error fetching user profile: $e');
      rethrow;
    }
  }

  Future<List<String>> getMeetupSpots(String userId) async {
  try {
    final DocumentSnapshot profile = await _firestore.collection('users').doc(userId).get();

    final data = profile.data() as Map<String, dynamic>?;

    final List<dynamic>? meetupSpots = data?['preferredMeetupSpots'] as List<dynamic>?;
    return meetupSpots?.map((e) => e.toString()).toList() ?? [];
  } catch (e) {
    debugPrint('Error fetching meetup spots: $e');
    return [];
  }
}



  // Listings
/*
  //new
  Future<void> addListing(String userId, Map<String, dynamic> listingData) async {
    try {
      await _firestore.collection('users').doc(userId).collection('listings').add(listingData);
      print('Listing added successfully!');
    } catch (e) {
      print('Error adding listing: $e');
    }
  }


  // update
  Future<void> updateListing(String userId, String listingId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('users').doc(userId).collection('listings').doc(listingId).update(updatedData);
      print('Listing updated successfully!');
    } catch (e) {
      print('Error updating listing: $e');
    }
  }


  // fetch
  Future<DocumentSnapshot> getListing(String userId, String listingId) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(userId).collection('listings').doc(listingId).get();
      print('Listing fetched successfully!');
      return snapshot;
    } catch (e) {
      print('Error fetching listing: $e');
      rethrow;
    }
  }


  // delete :(
  Future<void> deleteListing(String userId, String listingId) async {
    try {
      await _firestore.collection('users').doc(userId).collection('listings').doc(listingId).delete();
      print('Listing deleted successfully!');
    } catch (e) {
      print('Error deleting listing: $e');
    }
  }


  // fetch all -> implement ui on prof
  Future<QuerySnapshot> getAllListings(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').doc(userId).collection('listings').get();
      print('All listings fetched successfully!');
      return snapshot;
    } catch (e) {
      print('Error fetching listings: $e');
      rethrow;
    }
  }*/
}


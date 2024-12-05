import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:navigation/firebase/firestore_crud.dart';


class UserProfileProvider extends ChangeNotifier {
  final FirestoreCrud _firestoreCrud = FirestoreCrud();
  Map<String, dynamic>? _userProfile;


  Map<String, dynamic>? get userProfile => _userProfile;


  // Fetch the user's profile
  Future<void> fetchUserProfile(String userId) async {
    try {
      DocumentSnapshot snapshot = await _firestoreCrud.getUserProfile(userId);
      if (snapshot.exists) {
        _userProfile = snapshot.data() as Map<String, dynamic>;
      } else {
        // If no profile exists, create a dummy user
        await _firestoreCrud.addDummyUser(userId);
        _userProfile = {
          'name': 'Default Name',
          'bio': 'Default Bio',
          'email': 'default',
          'major': 'Undeclared',
          'gradDate': 2025,
          'preferredMeetupSpots': ['Red Square', 'Quad', 'Other'],
        };
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching user profile: $e');
    }
  }


  // Update the user's profile
  Future<void> updateUserProfile(String userId, Map<String, dynamic> updatedData) async {
    try {
      await _firestoreCrud.updateUserProfile(userId, updatedData);
      _userProfile = updatedData; // Update the local state
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating user profile: $e');
    }
  }
}






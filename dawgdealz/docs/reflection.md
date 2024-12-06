# Reflection

## Identify which of the course topics you applied and describe how you applied them.

### Stateless & Stateful Widgets
**Frontend implementation in Dart and Flutter for views and providers!**

#### Views:
- **Home Page:** Browse and search all listings from all users.
- **Item Entry View:** Create a new item listing.
- **Item Description View:** View a listing created by another seller, including its full description, condition, price, and images.
- **Sign Up:** Sign up to create a new account.
- **Log In:** Log in with an existing account.
- **Account View:** View your own profile.
- **Edit Profile:** Edit and save your own profile.
- **Seller Profile:** View another seller's profile.
- **User Listing:** View your own listings and delete an item once sold.

#### Providers:
- **Item Provider:** Shows changes to the Item Description once a new item is created.
- **Profile Provider:** Shows changes to Account View and Seller Profile when a new account is created or the current account is updated.

### Accessing Sensors (Force, GPS, etc.)
- **Camera Sensor & Image Picker:** Dynamically take photos or upload photos from the gallery.

### Querying Web Services
- **Gemini API:** AI generates a starter description based on the item name.
- **Flutter Email Sender & Flutter URL Launcher:** Automate messaging.

### Data Persistence
- **Firebase:** Storing data for Items and Users in the cloud:
  - **Authentication:** Users can create accounts, log in, and log out (usernames are stored).
  - **Firestore Database:**
    - Users can create profiles, set profile info (e.g., name, major, year, bio, contact, and preferred safe campus meeting spots), and update profile info.
    - Profiles are visible to other users, and the seller profile view is updated in real-time with information fetched from Firestore.
    - Users can create new items stored in a Firestore Collection and displayed on the home page, including name, description, price, condition, and photos.
    - Photos are stored in Firebase Storage with a unique listing ID.
    - Items are linked to unique user IDs to display under **My Listing**, allowing users to later delete them.
    - Clicking on a listing on the home page fetches Item information using a unique listing ID. Users can also view the seller’s profile because the unique user ID of whoever created the item is linked to the Item Description View.

### Properties of People
- **Design Tip #2: “Put commonly used items close together”**
  - We used a navigation bar to group commonly used items, making them accessible from all pages.

---

## Discuss how doing this project challenged and/or deepened your understanding of these topics.
1. **Firebase Integration:**  
   Taught us a lot about user authentication, backend services, and creating cross-functional apps.

2. **Navigation Bar:**  
   Adding a navigation bar made us think about how users interact with the app and taught us the importance of consistency across all pages for easier use.

3. **Prioritization:**  
   - Time constraints deepened our understanding of prioritization.  
   - Identified which features were “must-have” versus “nice-to-have.”

4. **Dynamic Updates for Deleted Items:**  
   - Managing asynchronous operations and state effectively.
   - Learned the importance of using unique keys for deletion queries.

5. **Firestore Collection:**  
   - Implemented scalable database structures.
   - Used Firestore's real-time listeners to dynamically update data.

6. **Managing Relationships Between Collections:**  
   - Leveraged seller IDs to query the Users collection and display updated profiles.
   - Understood the importance of efficient database schema design.

7. **Cross-Platform Compatibility:**  
   - Ensured APIs worked across iOS and Android.
   - Learned that compatibility testing is essential for consistent user experiences.

8. **API Integration:**  
   - Used Firebase API for user authentication, real-time data updates, and secure backend services.
   - GeminiAI API generated item descriptions based on titles, enhancing user experience and automating processes.

---

## Describe what changed from your original concept to your final implementation. Why did you make those changes?
1. **Map Feature:**  
   - Initially planned to show items on a map for better user experience.  
   - Omitted due to time constraints to focus on core functionality.

2. **Like Button & Report Feature:**  
   - Planned to add these for engagement and safety.  
   - Omitted due to time limitations, as they required additional logic for handling item popularity and user reporting.

---

## Describe two areas of future work for your app, including how you could increase the accessibility and usability of this app.

1. **More Expansive Filtered Search:**  
   - Allow users to search by category, price range, and location.  
   - Add filters for price, popularity/likes, and time posted.

2. **Stronger Security and Verification:**  
   - Integrate UW Duo Authentication to provide stronger account security for UW users.  
   - Reduce scams and increase trust within the community.

3. **More Customizable Profiles:**  
   - Allow users to upload profile photos to make the app more engaging.  
   - Select preferred meeting spots with a location pin on Google Maps.  
   - Use Gemini to autogenerate alt text for user-uploaded profile photos to increase accessibility.

4. **Interactive Features:**  
   - Enable users to like listings, report users, or leave ratings to encourage accountability among sellers.

---

## Cite anything (website or other resource) or anyone that assisted you in creating your solution to this assignment.
- [https://api.flutter.dev/flutter/material/Radio-class.html](https://api.flutter.dev/flutter/material/Radio-class.html)
- [https://api.flutter.dev/flutter/material/NavigationBar-class.html](https://api.flutter.dev/flutter/material/NavigationBar-class.html)
- [https://pub.dev/packages/image_picker](https://pub.dev/packages/image_picker)
- [https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility](https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility)
- [https://developers.google.com/learn/pathways/solution-ai-gemini-getting-started-dart-flutter](https://developers.google.com/learn/pathways/solution-ai-gemini-getting-started-dart-flutter)
- [https://firebase.google.com/docs/firestore/query-data/listen] (https://firebase.google.com/docs/firestore/query-data/listen)
- [https://firebase.google.com/products/functions](https://firebase.google.com/products/functions)
- [https://www.youtube.com/watch/13-jNF984C0](https://www.youtube.com/watch/13-jNF984C0)
- [https://stackoverflow.com/questions/56817428/firebase-should-i-store-user-data-on-the-authentication-profile-or-database](https://stackoverflow.com/questions/56817428/firebase-should-i-store-user-data-on-the-authentication-profile-or-database)
- [https://www.youtube.com/watch?v=G0rsszX4E9Q](https://www.youtube.com/watch?v=G0rsszX4E9Q)

---

## Finally: Thinking about CSE 340 as a whole:
### What do you feel was the most valuable thing you learned in CSE 340 that will help you beyond this class, and why?

1. **User-Centric Design:**  
   - Learned to create accessible interfaces focusing on end-user needs.  
   - Example: Created a Food Finder App that tailored suggestions based on geolocation and weather data.

2. **Adaptability:**  
   - Mastered working with Flutter and adapting to new tools/frameworks.  
   - Example: Implemented features like `PositionProvider` for geolocation and weather APIs.

3. **Real-World Relevance:**  
   - Learned skills critical for creating impactful and inclusive applications.  
   - Example: Refined layout and accessibility to mimic the iOS calculator.

---

## If you could go back and give yourself 2-3 pieces of advice at the beginning of the class, what would you say and why?
1. **Understand Flutter’s Framework Early:**  
   - Flutter is widget-based, which is very different from other languages.  
   - Learning how stateful and stateless widgets work in the first few weeks is very important, especially using providers.

2. **Test Early and Often:**  
   - Don’t wait until the end to test your app.  
   - Run code frequently and test features in small increments as you build them.  
   - Early testing simplifies debugging and catches errors before they grow into larger issues.

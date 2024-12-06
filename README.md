A project for CSE 340 by Jason Kim, Aynur Sari, Salim Moshe, and Andrea Danila.


# DawgDealz

DawgDealz is a Flutter app for creating and browsing listings in a marketplace. Users can add items for sale, search for items, and manage their profiles with Firebase Firestore and Storage integration. DawgDealz addresses the essential need for a secure and convenient marketplace tailored specifically for university students. Many students face financial constraints and require an affordable way to buy and sell items within their campus community. Traditional platforms often lack the safety and locality that students desire. DawgDealz fills this gap by providing a trusted, community-focused app where students can easily exchange goods, promoting sustainability through the reuse of items and fostering stronger campus connections.

> **Note:** DawgDealz currently supports iPhone, Android devices, and the iOS simulator. It is not configured for web or desktop platforms.


## Installation

1. Clone the repository:
   ```bash
   git clone [REPOSITORY_URL]

2. Navigate to the project directory:
   ```bash
   cd DawgDealz

3. Install dependencies using Flutter:
   ```bash
   flutter pub get

4. Run the app
   ```
   flutter run

## Project Structure
   ```bash
├── lib
│   ├── main.dart                    # Entry point of the Flutter app
│   ├── firebase_options.dart        # Firebase configuration for the app
│   ├── auth_service.dart            # User authentication with firebase     
│   ├── views                        # Contains UI components
│   │   ├── account_view.dart        # User's Profile Page
│   │   ├── edit_profile.dart        # Edit User Profile Page
│   │   ├── home_page.dart           # Home Page 
│   │   ├── item_description_view.dart # Listing Description Page
│   │   ├── item_entry_view.dart     # Create New Item Page
│   │   ├── login.dart               # Log in Page
│   │   ├── signup.dart              # Sign up Page
│   │   ├── seller_profile.dart      # Seller Profile Page
│   │   ├── user_listing.dart        #  Listings Page
│   ├── models                       # Contains ata models and providers
│   │   ├── item.dart                # Model class for items
│   │   ├── item_provider.dart       # Item Provider
│   │   ├── profile_provider.dart    # Profile Provider
│   ├── helpers                      # Utility functions
│   │   ├── upload.dart              # Handles image uploads
│   ├── firebase                     # Contains firebase functionality
│   │   ├── firestore_crud.dart              # Firestore, create and update features

```
## Dependencies

The following dependencies are used in the DawgDealz project :

- **firebase_core**: For initializing Firebase in the app.
- **firebase_auth**: For user authentication.
- **cloud_firestore**: For storing and retrieving listing data.
- **firebase_storage**: For managing item images.
- **provider**: For state management.
- **image_picker**: For uploading photos from the gallery or camera.
- **url_launcher**: For sending emails.
- **google_generative_ai**: For writing AI generated item descriptions.

## Usage

### Listings Page
Displays all items for sale.

### Create Page
Add new items with details like name, description, and images.

### My Listings Page
Displays only the items the user posted. 

### Profile Page
Edit user profile details.

## Firebase Integration
- **Authentication**: Used to identify users.
- **Firestore**: Stores item details, including name, description, and images. Stores profile details, including name, bio, major, year, and preferred safe campus meeting spots.
- **Storage**: Handles image uploads for items.

## Data Design

Our app utilizes Firebase Firestore as the primary backend to store user and item data. The following data structures were designed to manage this information effectively:

-User Data:
- Fields: name, email, bio, major, gradDate, and preferredMeetupSpots.
- Structure: Each user is represented as a document in the users collection, with a unique uid assigned at authentication.

- Item Data:
- Fields: name, price, description, images, condition, timestamp, and userId.
- Structure: Each item is a document in the items collection, with its own unique listing ID assigned upon creation. It is also linked to its seller's userId for cross-referencing.

##Flow

Profile Management:
- A ProfileProvider fetches and caches user profile data.
- When a user updates their profile, changes are written to Firestore and the Provider notifies dependent widgets to re-render automatically.


Item Listings:

- An ItemProvider manages a list of items fetched from Firestore.
- Changes such as new items or deleted are reflected in real-time using Firestore.



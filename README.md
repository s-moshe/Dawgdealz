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
│   ├── views                        # Contains UI components
│   │   ├── custom_widget1.dart      # Listings Page
│   │   ├── item_entry_view.dart     # Create Page
│   │   ├── custom_widget5.dart      # Profile Page
│   ├── models                       # Data models
│   │   ├── item.dart                # Model class for items
│   ├── helpers                      # Utility functions
│   │   ├── upload.dart              # Handles image uploads

```
## Dependencies

The following dependencies are used in the DawgDealz project :

- **firebase_core**: For initializing Firebase in the app.
- **firebase_auth**: For user authentication.
- **cloud_firestore**: For storing and retrieving listing data.
- **firebase_storage**: For managing item images.
- **provider**: For state management.
- **image_picker**: For uploading photos from the gallery or camera.

## Usage

### Listings Page
Displays all items for sale.

### Create Page
Add new items with details like name, description, and images.

### Profile Page
Edit user profile details and view personal listings.

## Firebase Integration
- **Authentication**: Used to identify users.
- **Firestore**: Stores item details, including name, description, and images.
- **Storage**: Handles image uploads for items.


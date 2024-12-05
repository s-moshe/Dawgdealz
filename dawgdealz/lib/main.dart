import 'package:flutter/material.dart';
import 'package:navigation/models/item_provider.dart';
import 'package:navigation/models/profile_provider.dart';
import 'package:navigation/views/home_page.dart';
import 'package:navigation/views/item_entry_view.dart';
import 'package:navigation/views/account_view.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:navigation/views/user_listing.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:navigation/views/login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    /*ChangeNotifierProvider(
      create: (_) => ItemProvider(), // Provide the single provider
      child: const MyApp(),


    )*/
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create : (_) => ItemProvider()),
        ChangeNotifierProvider(create : (_) => UserProfileProvider()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DawgDealz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}


class NavDemo extends StatefulWidget {
  const NavDemo({super.key, required this.title});
  final String title;

  @override
  State<NavDemo> createState() => _NavDemoState();
}

class _NavDemoState extends State<NavDemo> {
  
  // We will use this to keep track of what tab is selected
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
          setState((){ // Executes code and then causes widget to re-build()
            _currentTabIndex = index;
          });
        },
        indicatorColor: theme.primaryColor,
        selectedIndex: _currentTabIndex,

        // This defines what is in the nav bar 
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home' ),
          NavigationDestination(icon: Icon(Icons.add), label: 'New Listing'),
          NavigationDestination(icon: Icon(Icons.upload), label: 'My Listing'),
          NavigationDestination(icon: Icon(Icons.import_contacts), label: 'Account')
        ],
      ),
      
      // Here we choose how to populate the body using the current value of _currentTabIndex
      body: Center(child: 
        switch (_currentTabIndex) {
          0 => const HomePage(),
          1 => const ItemEntryView(),
          2 => const UserListing(),
          3 => AccountView(),
          _ => const HomePage()
        }
      )
    );
  }
}
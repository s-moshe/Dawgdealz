import 'package:flutter/material.dart';
import 'package:navigation/views/custom_widget1.dart';
import 'package:navigation/views/item_entry_view.dart';
import 'package:navigation/views/custom_widget3.dart';
import 'package:navigation/views/custom_widget4.dart';
import 'package:navigation/views/custom_widget5.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
) ;
  runApp(const MyApp());
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
      home: const NavDemo(title: 'DawgDealz'),
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
        title: Text(widget.title),
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
          NavigationDestination(icon: Icon(Icons.navigation), label: 'Discovery'),
          NavigationDestination(icon: Icon(Icons.add), label: 'New Listing'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Watching'),
          NavigationDestination(icon: Icon(Icons.import_contacts), label: 'Account')
        ],
      ),
      
      // Here we choose how to populate the body using the current value of _currentTabIndex
      body: Center(child: 
        switch (_currentTabIndex) {
          0 => const CustomWidget1(),
          1 => const CustomWidget3(),
          2 => const ItemEntryView(),
          3 => const CustomWidget4(),
          4 => const CustomWidget5(),
          _ => const CustomWidget1()
        }
      )
    );
  }
}
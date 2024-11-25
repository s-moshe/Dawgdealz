import 'package:flutter/material.dart';
import 'package:navigation/views/donut_widget.dart';

class CustomWidget3 extends StatelessWidget {
  const CustomWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     const Text('Hello from Widget 3'),
    //     ElevatedButton(
    //       onPressed: (){_giveDonut(context);}, 
    //       child: const Text('Press for Donut')),
    //   ],
    // );
    return const Text("test");
  }

  // _giveDonut(context){
  //   Navigator.push(context, 
  //       MaterialPageRoute(builder: (context) => const DonutWidget()),
  //   );
  // }
}
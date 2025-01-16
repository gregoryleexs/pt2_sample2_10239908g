import 'package:flutter/material.dart';
import 'package:pt2_sample2_10239908g/Bill.dart';

class secondScreen extends StatefulWidget{
  secondScreen({super.key});

  secondScreenState createState() => secondScreenState();
}

class secondScreenState extends State<secondScreen>
{
  //variables
  String billDescription = '';
  int billCost = 0;

  //controllers
final descriptionField = TextEditingController();
final costField = TextEditingController();

@override
  Widget build(BuildContext context)
{
  return Scaffold(appBar: AppBar(title: const Text("Second Screen")), body: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
    //dd
    TextField(controller: descriptionField, decoration: InputDecoration(hintText: "Name"), onChanged: (value) {
      setState(() {
        billDescription = value;
      });
    },),
    TextField(controller: costField, decoration: InputDecoration(hintText: "Amount to pay"), onChanged: (value) {
      setState(() {
        billCost = int.parse(value);
      });
    },),
    ElevatedButton(onPressed: () {

      Navigator.pop(context, Bill(name: billDescription, cost: billCost));
    }, child: const Text("Save"),)
  ],),);
}
}
import 'package:flutter/material.dart';
import 'package:pt2_sample2_10239908g/Bill.dart';
import 'package:pt2_sample2_10239908g/secondScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  MyAppState createState() => MyAppState();


}

class MyAppState extends State<MyApp> {
  //variables
  List<Bill> billList = [];
  int totalAmt = 0;

  @override
  Widget build (BuildContext context)
  {
    return MaterialApp(home: Scaffold(appBar: AppBar(title: const Text("First Screen")), body: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      //dd
      Padding(padding: const EdgeInsets.all(20), child:  Text("My Bills", style: TextStyle(fontSize: 28,), textAlign: TextAlign.center,)),
     Builder(builder: (BuildContext context) {
       return ElevatedButton(onPressed: () async {
         //databack should be type Bill.
         final Bill databack = await Navigator.push(context, MaterialPageRoute(builder: (context) {
           return secondScreen();
         }));
         setState(() {
           billList.add(databack);
         });
         final sb = SnackBar(content: Text("New bill added"));
         ScaffoldMessenger.of(context).showSnackBar(sb);
       }, child: const Text("Add New Bill", style: TextStyle(fontSize: 20)),);
     }),
      Builder(builder: (BuildContext context) {
        return ElevatedButton(onPressed: () {
          //calculate the total amount before clearing list!
          setState(() {
            //ENHANCEMENT added delete only selected
            //first BEFORE touching the list, add total amount to be paid
            for(Bill b in billList)
            {

              if(b.selectedForDeletion)
                {
                  totalAmt += b.cost;
                }

            }
            //then use removeWhere with a condition to remove paid bills.
            billList.removeWhere((b) {
              return b.selectedForDeletion == true;

            });
          });
          final sb = SnackBar(content: Text("Paid total amount: " + totalAmt.toString()));
          ScaffoldMessenger.of(context).showSnackBar(sb);
          //reset total amount
          setState(() {
            totalAmt = 0;
          });
        }, child: const Text("Dummy Pay", style: TextStyle(fontSize: 20)),);
      }),
      Expanded(child: ListView.builder(scrollDirection: Axis.vertical, shrinkWrap: true, itemCount: billList.length, itemBuilder: (BuildContext context, int index) {
        //dd
        return ListTile(title: Text(billList[index].name + ", " + billList[index].cost.toString()), trailing: Checkbox(value: billList[index].selectedForDeletion, onChanged: (bool? value) {
          setState(() {
            billList[index].selectedForDeletion = value ! ? true:false;
          });
        }),);
      },)),
    ],)));
  }
}


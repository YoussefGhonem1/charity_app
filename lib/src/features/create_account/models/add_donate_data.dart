import 'package:cloud_firestore/cloud_firestore.dart';



 
void AddDonateModel()async{



 @override
  void initState() {
    initState();
  }

  
final firestore =FirebaseFirestore.instance;


final donateItems = [

{

"title": "save homeless people",
"location":"kosovo",
"story":"please be kind and donate for them they need you,you can make them feel better ",
"requiredAmount":"112 ",
"collectionPeriod":"Two days",
"photo":"https://th.bing.com/th/id/OIP.LmSO6fRCE3HuW1D_a4JAmwHaE8?w=273&h=182&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3",
},

];


for(var item in donateItems) {
  await firestore.collection("donateItems").add(item);
}


print('Data added automatically !!');



}

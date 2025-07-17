import 'package:abc/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Practice1 extends StatefulWidget {
   Practice1({super.key});

  @override
  State<Practice1> createState() => _Practice1State();
}

class _Practice1State extends State<Practice1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<EligibilityProvider>(
            create: (context) => EligibilityProvider(),),

          ChangeNotifierProvider<ConnectivityProvider>(
            create: (context) => ConnectivityProvider(),
          )
        ],
          child:Consumer<EligibilityProvider>(builder: (context, value, child) => Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(

                  )
                ),
                onChanged: (val){
                  value.checkEligibility(int.parse(val));
                },
              ),
              SizedBox(height: 5,),

              Text(value.text.toString(),style: TextStyle(color: value.isEligible?Colors.green:Colors.red),),

              const SizedBox(height: 20,),

              Consumer<ConnectivityProvider>(
                builder: (context, value, child) =>
                ElevatedButton(onPressed: ()async {
                  await value.checkConnection();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.text), backgroundColor: value.isConnected?Colors.green:Colors.red,));
                }, child:const Text("Check Connection")),
              ),
            ],
          ),
            )
        ),
    );
  }
}

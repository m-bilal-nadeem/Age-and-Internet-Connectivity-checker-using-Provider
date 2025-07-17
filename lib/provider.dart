import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class EligibilityProvider with ChangeNotifier {
  String text = "";
  bool isEligible = false;
  int? age;

  void checkEligibility(int age){
    if(age>=18){
      text = "You are eligible";
      isEligible = true;
      notifyListeners();
    }
    else{
      text = "You are not eligible";
      isEligible = false;
      notifyListeners();
    }
  }
}


class ConnectivityProvider with ChangeNotifier{
  Connectivity connectivity = Connectivity();
  var connectivityResult;
  bool isConnected = false;
  String text = "";

  Future<void> init()async{
    connectivityResult = await connectivity.checkConnectivity();
    notifyListeners();
  }

  Future<void> checkConnection()async{
    connectivityResult = await connectivity.checkConnectivity(); // directly call this here
    if(connectivityResult == ConnectivityResult.mobile){
      debugPrint("Connected to mobile\n");
      text = "Connected to mobile";
      isConnected = true;
      notifyListeners();
    }
    else if(connectivityResult == ConnectivityResult.wifi){
      debugPrint("Connected to wifi\n");
      text = "Connected to Wifi";
      isConnected = true;
      notifyListeners();
    }
    else if(connectivityResult == ConnectivityResult.vpn){
      debugPrint("Connected to vpn\n");
      text = "Connected to vpn";
      notifyListeners();
    }
    else if(connectivityResult == ConnectivityResult.ethernet){
      debugPrint("Connected to ethernet\n");
      text = "Connected to ethernet";
      isConnected = true;
      notifyListeners();
    }
    else if(connectivityResult == ConnectivityResult.bluetooth){
      print("Connected to bluetooth\n");
      text = "Connected to bluetooth";
      notifyListeners();
    }
    else if(connectivityResult == ConnectivityResult.none){
      debugPrint("Not connected to internet\n");
      text = "Not Connected to internet";
      notifyListeners();
    }
    else{
      debugPrint("An error while connecting to internet\n");
      text = "An error while connecting to internet";
      notifyListeners();
    }
     print(connectivityResult);
  }

  void startListening() {
    connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      connectivityResult = result;
      checkConnection();
    });
  }


}
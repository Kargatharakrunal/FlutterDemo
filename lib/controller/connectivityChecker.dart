

//Check internet connection
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityChecker {
  Future<bool> checkConnectivity() async {
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      print("Device connected with internet");
      return true;
    } else {
      print("Device not connected with internet");
      return false;
    }
  }
}

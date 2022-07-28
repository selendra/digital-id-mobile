import 'package:http/http.dart' as http;
import 'package:wallet_apps/index.dart';

class GetRequest{

  Future<void> getUnApproveDocs(String signature) async {
    final response = await http.get(
      Uri.parse('https://attestation.koompi.org/claims/user'),
      headers: {
        "accept": "application/json",
        "Authorization": signature,
      }
    );

    if(response.statusCode == 200){
      print("Pending Data: ${jsonDecode(response.body)}");
    }
    else{
      print("No Data Found");
    }

  }

  Future<void> getPropertyURI(String signature) async {
    final response = await http.get(
      Uri.parse('https://gateway.kumandra.org/api/add'),
    );
    

    if(response.statusCode == 200){
      print("getPropertyURI: ${jsonDecode(response.body)}");
    }
    else{
      print("getPropertyURI: No Data Found");
    }

  }
}
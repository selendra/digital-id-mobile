import "package:http/http.dart" as http;
import 'package:wallet_apps/index.dart';

class PostRequest{

  Future<void> postQrDigital(
    String url, 
    String id, 
    String signature, 
    String publicKey
  ) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "id": id,
          "signature": "Web3 ${signature}",
          "publicKey": publicKey,
        })
      );
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<void> postCreateDocs(
    String signature, 
    int ctypeId, 
    String to, 
    String name, 
    String propertyURI, 
    String propertyHash,
    String attester
  ) async {
    try {
      final response = await http.post(
        Uri.parse("https://attestation.koompi.org/claims/create"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": signature,
        },
        body: jsonEncode({
          "ctypeId": ctypeId,
          "to": to,
          "name": name,
          "propertyURI": propertyURI,
          "propertyHash": propertyHash,
          "attester": attester
        })
      );
      
      if(response.statusCode == 200){
        print("postCreateDocs: Created Data");
      }
      else{
        print("postCreateDocs: Error");
      }

    } catch (e) {
      print(e);
    }
  }

}
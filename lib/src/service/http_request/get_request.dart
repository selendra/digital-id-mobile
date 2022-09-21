import 'package:http/http.dart' as _http;
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/api/api.dart';

class GetRequest{
  _http.Response? _res;

  Future<void> getUnApproveDocs(String signature) async {
    final response = await _http.get(
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
    final response = await _http.get(
      Uri.parse('https://gateway.kumandra.org/api/add'),
    );
    

    if(response.statusCode == 200){
      print("getPropertyURI: ${jsonDecode(response.body)}");
    }
    else{
      print("getPropertyURI: No Data Found");
    }

  }


  Future<_http.Response> querySubmittedDocs(String addr) async {
    print("querySubmittedDocs $addr");
    try {

      _res = await _http.get(Uri.parse(Api.assetOf + addr));
      print("_res ${_res!.statusCode}");
    } catch (e) {
      print("Error querySubmittedDocs $e");
    }
    return await _res!;
  }
}
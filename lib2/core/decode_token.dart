import 'dart:convert';
import 'package:flutter/material.dart';

class JwtDecode {
  // ignore: missing_return
  static Map<String, dynamic>? tryParseJwt(String token, BuildContext context) {
    final parts = token.split('.');
    if (parts.length != 3) {
      return null;
    }
    final payload = parts[1];
    var normalized = base64Url.normalize(payload);
    var resp = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(resp);
    if (payloadMap is! Map<String, dynamic>) {
      return null;
    }
    print(payloadMap.toString());
    //  print("Token : $token \n\n");
    //  print("After decoding a token by using JWT Decode : $payloadMap");
    //  if(payloadMap['role'] == "teacher"){
    //   //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainDashboard(owner_id: payloadMap['id'],fullname: payloadMap['fullname'])));
    //  }else{
    //   //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage(checkAppbar: "login")));
    //  }
  }
}

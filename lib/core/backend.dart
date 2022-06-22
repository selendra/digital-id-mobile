import 'dart:convert';
import 'dart:math';

import 'package:digital_id/all_export.dart';
import 'package:http/http.dart' as _http;
import 'package:digital_id/core/config/app_config.dart';
import 'package:digital_id/models/sign_up_m.dart';
import 'package:digital_id/services/storage.dart';
import 'package:encrypt/encrypt.dart';

  _http.Response? _res;
  Map<String, dynamic>? _decode; 
  String? _bodyEncode; 
  Map<String, dynamic>? _token;

class Backend {

  final String _api = "https://accounts.koompi.com/";
  final String _sdApi = "https://student.saladigital.org/";

  Future<String> _otpContents() async {

    // Random 4digit Number
    int _otpCode = Random().nextInt(9999);

    print("OTP $_otpCode");

    // Encrypted OTP Code
    Encrypted encrypted =  Encryption().encryptAES(json.encode(_otpCode));

    // Store OTP Code Encrypted As Bytes
    await StorageServices.storeData(encrypted.bytes, DbKey.otpCode); 
    
    return """
      <html>
      <header>

      <style>

      @import url('https://fonts.googleapis.com/css?family=Open+Sans');
      * {
            box-sizing: border-box;
        }
        body {
            background-color: #fafafa;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .c-email {
            border-radius: 40px;
            overflow: hidden;
            box-shadow: 0px 7px 22px 0px rgba(0, 0, 0, .1);
        }
        .c-email__header {
            background-color: #0fd59f;
            width: 100%;
            height: 60px;
        }
        .c-email__header__title {
            font-size: 23px;
            font-family: 'Open Sans';
            height: 60px;
            line-height: 60px;
            margin: 0;
            text-align: center;
            color: white;
        }
        .c-email__content {
            width: 100%;
            height: 300px;
            display: flex;
            flex-direction: column;
            justify-content: space-around;
            align-items: center;
            flex-wrap: wrap;
            background-color: #fff;
            padding: 15px;
        }
        .c-email__content__text {
            font-size: 20px;
            text-align: center;
            color: #343434;
            margin-top: 0;
        }
        .c-email__code {
            display: block;
            width: 60%;
            margin: 30px auto;
            background-color: #ddd;
            border-radius: 40px;
            padding: 20px;
            text-align: center;
            font-size: 36px;
            font-family: 'Open Sans';
            letter-spacing: 10px;
            box-shadow: 0px 7px 22px 0px rgba(0, 0, 0, .1);
        }
        .c-email__footer {
            width: 100%;
            height: 60px;
            background-color: #fff;
        }
        .text-title {
            font-family: 'Open Sans';
        }
        .text-center {
            text-align: center;
        }
        .text-italic {
            font-style: italic;
        }
        .opacity-30 {
            opacity: 0.3;
        }
        .mb-0 {
            margin-bottom: 0;
        }
        </style>
      </header>
      
      <body>

        <div class="c-email">  
        
          <div style="background-color: #0fd59f; width: 100%; height: 60px;">
            <h1 style="color: white; font-size: 23px; text-align: center;">Your Verification Code</h1>
          </div>
          <div class="c-email__content">
            <p class="c-email__content__text text-title">
              Enter this verification code in field:
            </p>
            <div
              <span style="font-weight: bold;">$_otpCode</span>
            </div>
            <p class="c-email__content__text text-italic opacity-30 text-title mb-0">Verification code is valid only for 30 minutes</p>
          </div>
          <div class="c-email__footer"></div>
        </div>

      </body>
    </html>
    """;
  }

  /// Http Header
  Map<String, String> _conceteHeader({String? key, String? value}) { /* Concete More Content Of Header */
    return key != null 
    ? { /* if Parameter != Null = Concete Header With  */
      "Content-Type": "application/json; charset=utf-8", 
      'accept': 'application/json',
      key: value!
    }
    : { /* if Parameter Null = Don't integrate */
      "Content-Type": "application/json; charset=utf-8",
      'accept': 'application/json'
    };
  }

  Map<String, String> _multipartHeader(String? _key, String? _value) { /* Concete More Content Of Header */
    return _key != null 
    ? { /* if Parameter != Null = Concete Header With  */
      "Content-Type": "multipart/form-data", 
      _key: _value!
    }
    : { /* if Parameter Null = Don't integrate */
      "Content-Type": "multipart/form-data"
    };
  }

  Future<_http.Response> login(String? email, String? passwords) async {
    print("login ");
    print("signUpModel.emailInputController.text ${email}");
    print("signUpModel.passwordInputController.text ${passwords}");
    // "authorization", "Bearer ${_token!['token']}}"
      // _token = await StorageServices.fetchData(DbKey.token);
    _bodyEncode = json.encode({ /* Convert to Json String */
      "email": email,
      "password": passwords
    });
    _res = await _http.post(Uri.parse(_sdApi+"login"), headers: _conceteHeader(), body: _bodyEncode);
    return _res!;
  }

  Future<_http.Response> register(SignUpModel? signUpModel) async {

    // print("signUpModel!.userNameController ${signUpModel!.userNameController.text}");
    // print("signUpModel.emailInputController.text ${signUpModel.emailInputController.text}");
    // print("signUpModel.passwordInputController.text ${signUpModel.passwordInputController.text}");
    // print("signUpModel.conPasController.text ${signUpModel.conPasController.text}");

    _bodyEncode = json.encode({ /* Convert to Json String */
      "fullname": signUpModel!.userNameController.text,
      "email": signUpModel.emailInputController.text,
      "password": signUpModel.passwordInputController.text,
      "confirmPassword": signUpModel.conPasController.text
    });
    _res = await _http.post(Uri.parse(_api+"register"), headers: _conceteHeader(), body: _bodyEncode);
    return _res!;
  }

  Future<_http.Response> getOtp(String? email) async {
    print("getOtp");
    _bodyEncode = json.encode({ /* Convert to Json String */
      "sender": { 
        "name": "StudentID's Admin", 
        "email":"condaveat@gmail.com" 
      }, "to":[ { "email": "$email", "name":"John Doe" } ], 
      "subject": "Hello", 
      "htmlContent": await _otpContents()
    });
    _res = await _http.post(Uri.parse("https://api.sendinblue.com/v3/smtp/email"), headers: _conceteHeader(key: 'api-key', value: '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'), body: _bodyEncode);
    print("_res ${_res!.body}");

    return _res!;
  }

}
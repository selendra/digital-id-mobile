import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:hex/hex.dart';

// ignore: avoid_classes_with_only_static_members
class StorageServices {
  
  static String? _decode;
  static SharedPreferences? _preferences;

  // final _storage = const FlutterSecureStorage();

  // Future<String>? readSecure(String key) async {

  //   String? res = await _storage.read(key: key);
  //   return res != null ? res : '';
  // }

  // Future<void> writeSecure(String key, String value) async {
  //   await _storage.write(key: key, value: value);
  // }

  // Future<void> clearKeySecure(String key) async {
  //   await _storage.delete(key: key);
  // }

  // Future<void> clearSecure() async {
  //   await _storage.deleteAll();
  // }

  Future<void> clearStorage() async {
    _preferences = await SharedPreferences.getInstance();
    await _preferences!.clear();
  }

  static Future<SharedPreferences> storeData(dynamic _data, String _path) async {
    print("storeData $_data");
    
    try {

      _preferences = await SharedPreferences.getInstance();
      _decode = jsonEncode(_data);
      _preferences!.setString(_path, _decode!);
    } catch (e){
      print("Error storeData $e");
    }
    return _preferences!;
  }

  static Future<SharedPreferences> addMoreData(Map<String, dynamic> _data, String _path) async {
    List<Map<String, dynamic>> ls = [];
    _preferences = await SharedPreferences.getInstance();
    if (_preferences!.containsKey(_path)) {
      final _dataString = _preferences!.getString(_path);

      ls = List<Map<String, dynamic>>.from(jsonDecode(_dataString!) as List);
      ls.add(_data);
    } else {
      ls.add(_data);
    }

    _decode = jsonEncode(ls);
    _preferences!.setString(_path, _decode!);
    return _preferences!;
  }

  // ignore: avoid_positional_boolean_parameters
  static Future<void> saveBool(String key, bool value) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences!.setBool(key, value);
  }

  static Future<bool>? readBool(String key) async {
    _preferences = await SharedPreferences.getInstance();
    final res = _preferences!.getBool(key);

    return res!;
  }

  static Future<dynamic> fetchData(String _path) async {
    _preferences = await SharedPreferences.getInstance();

    final _data = _preferences!.getString(_path);

    if (_data == null) {
      return null;
    } else {
      return json.decode(_data);
    }
  }

  static Future<void> removeKey(String path) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences!.remove(path);
  }

  static Future<Map?> getSeeds(String? seedType) async {
    _preferences = await SharedPreferences.getInstance();
    String? value = await _preferences!.getString('wallet_seed_$seedType');
    if (value != null) {
      return jsonDecode(value);
    }
    return {};
  }

  static Future<void> clearAllData() async {
    _preferences = await SharedPreferences.getInstance();
    await _preferences!.clear();
  }
}

class Encryption {
  
  static final _key = encrypt.Key.fromLength(32);
  final _iv = encrypt.IV.fromLength(16);
  final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  Encrypted encryptAES(txt){
    return _encrypter.encrypt(txt, iv: _iv);
  }  

  String decryptAES(txt){

    //1. Parse List<dynamic> to List int
    List<int> lsInt = List<int>.from(txt);
    
    //2. Parse List Int To Uint8List
    return _encrypter.decrypt(Encrypted(Uint8List.fromList(lsInt)), iv: _iv);
  }
}

class EncryptionRSA {
  
  String pubKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCeK3soe4K8UCbc2m6famiLMzQi+DbOmgiWri31GnuIS3WpKfDaigbybhQ5uVPBKEFrMH4jvhuK5sK4zbshgbk8UO0LaTNRQTDLthpU8aUHnVeL9KBr9MzvhFgUYzPlje8oLGIOHHrhwWf+BBDIj1FfCloTULyCh29x8iS1rTh89wIDAQA";
  String? prKey;
  String? inputTxt;
  RSAKeyParser _keyParser = RSAKeyParser();
  Encrypted? encrypted;

  // EncryptionRSA(String key){
  //   // prKey = key; 
  // }

  // Encrypted encryptRSA(txt) {

  //   RSAAsymmetricKey serverPubKeyParser = _keyParser.parse("-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCeK3soe4K8UCbc2m6famiLMzQi+DbOmgiWri31GnuIS3WpKfDaigbybhQ5uVPBKEFrMH4jvhuK5sK4zbshgbk8UO0LaTNRQTDLthpU8aUHnVeL9KBr9MzvhFgUYzPlje8oLGIOHHrhwWf+BBDIj1FfCloTULyCh29x8iS1rTh89wIDAQAB\n-----END PUBLIC KEY-----");
    
  //   // This serVerprivateKeyParser is missing 
  //   RSAAsymmetricKey serVerprivateKeyParser = _keyParser.parse("-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCeK3soe4K8UCbc2m6famiLMzQi+DbOmgiWri31GnuIS3WpKfDaigbybhQ5uVPBKEFrMH4jvhuK5sK4zbshgbk8UO0LaTNRQTDLthpU8aUHnVeL9KBr9MzvhFgUYzPlje8oLGIOHHrhwWf+BBDIj1FfCloTULyCh29x8iS1rTh89wIDAQAB\n-----END PUBLIC KEY-----");;
    
  //   final publicKey = RSAPublicKey(serverPubKeyParser.modulus!, serverPubKeyParser.exponent!);
  //   final privKey;

  //   privKey = RSAPrivateKey(serVerprivateKeyParser.modulus!, serVerprivateKeyParser.exponent!, serVerprivateKeyParser.p, serVerprivateKeyParser.q);

  //   final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey:privKey));

  //   // Account 
  //   encrypted = encrypter.encrypt("0xc0571cca404abae232c6d2f376047910f2c2f4730d5c80e0e04ce091adad7a2c");
  //   return encrypted!;
  // } 

  // String decryptRSA(txt){

    // //1. Parse List<dynamic> to List int
    // List<int> lsInt = List<int>.from(txt);
    
    // //2. Parse List Int To Uint8List
    // return _encrypter!.decrypt(Encrypted(Uint8List.fromList(lsInt)), iv: _iv);
  // }
  
  // final bytes = hex.decode(cert.publicKeyData.bytes!);

  // final key = CryptoUtils.rsaPublicKeyFromDERBytes(Uint8List.fromList(bytes));
  // final pem = CryptoUtils.encodeRSAPublicKeyToPemPkcs1(key);
}
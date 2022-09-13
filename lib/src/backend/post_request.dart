import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wallet_apps/index.dart';
import 'package:http/http.dart' as _http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';

class PostRequest {

  // Upload Fil Image To Get Url Image
  Future<String> upLoadImage(File _image) async {

    print("Uploading image $_image");
    // print("Endpoint $endpoint");

    /* Compress image file */
    Uint8List? compressImage = await FlutterImageCompress.compressWithFile(
      _image.path,
      minHeight: 900,
      minWidth: 600,
      quality: 100,
    );
    /* Make request */

    var request = new _http.MultipartRequest('POST', Uri.parse('${ dotenv.get(AppConfig.kmdApi) }/api/add'));
    
    /* Make Form of Multipart */
    var multipartFile = new _http.MultipartFile.fromBytes(
      'file',
      compressImage!.toList(),
      filename: 'image_picker.jpg',
      contentType: MediaType.parse('image/jpeg'),
    );
    request.files.add(multipartFile);

    /* Start send to server */
    String? imageUrl;
    try{
      var r = await request.send();
      if (r.statusCode != 522){
        imageUrl = await r.stream.bytesToString();
      } else if (r.statusCode == 522){
        imageUrl = r.statusCode.toString();
      }
    } catch (e) {
      // print(e);
    }
    return imageUrl!;
  }
}
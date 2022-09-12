import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';

class SearchUtils {

  static Map<String, dynamic> searchOrgByOwnerId(BuildContext context, String? ownerId){

    print("searchOrgByOwnerId $ownerId");
    print("Provider.of<DocumentProvider>(context, listen: false).object!['organizations'] ${Provider.of<DocumentProvider>(context, listen: false).object!['organizations']}");
    Map<String, dynamic> tmp = {}; 
    for (int i = 0; i < Provider.of<DocumentProvider>(context, listen: false).object!['schemas'].length; i++){
      print("Provider.of<DocumentProvider>(context, listen: false).object!['schemas'][i]['owner'] == ownerId ${Provider.of<DocumentProvider>(context, listen: false).object!['schemas'][i]['owner'] == ownerId}");
      if (Provider.of<DocumentProvider>(context, listen: false).object!['schemas'][i]['owner'] == ownerId){
        tmp = Provider.of<DocumentProvider>(context, listen: false).object!['schemas'][i];
        break;
      }
    }
    
    return tmp;
  }
}
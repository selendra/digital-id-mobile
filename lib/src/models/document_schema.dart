class DocumentSchema {

  String? type;
  List? docsList;
  List<dynamic>? docsProperty;
  DocumentSchema({this.type, this.docsList, this.docsProperty});
}

class DocumentProperty{

  String? title;
  String? image;
  String? color;
  
  DocumentProperty({this.title, this.image, this.color});
}
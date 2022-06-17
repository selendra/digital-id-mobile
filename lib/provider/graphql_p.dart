import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:digital_id/all_export.dart';

class GraphQlProvider extends ChangeNotifier{

  HttpLink _httpLink = HttpLink('https://id.saladigital.org/admin');

  GraphQLClient? _client;

  late final AuthLink? _authLink;

  late ValueNotifier<GraphQLClient> clientNotifier = ValueNotifier<GraphQLClient>(_client!);

  set setAuthToken(String tk){
    print("setAuthToken $tk");
    _authLink = AuthLink(
      getToken: () async => "Bearer $tk"
    );
    resetClient();

    notifyListeners();
  }
  
  GraphQLClient get getClient => _client!;

  GraphQlProvider(){
    _client = GraphQLClient(
      link: _httpLink,
      cache: GraphQLCache(),
    );
  }

  void resetClient() async {
    Link _link = _authLink!.concat(_httpLink);
    _client = GraphQLClient(
      link: _link,
      cache: GraphQLCache(),
    );
  }

}

String? typenameDataIdFromObject(Object object) {
  if (object is Map<String, Object> &&
      object.containsKey('__typename') &&
      object.containsKey('id')) {
    return "${object['__typename']}/${object['id']}";
  }
  return null;
}

class GraphQLConfiguration  with ChangeNotifier{

  // ignore: avoid_init_to_null
  static Link? link;
  static HttpLink httpLink = HttpLink("https://id.saladigital.org/admin");
  static void setToken(String token) {
    print("setToken token $token");
    AuthLink alink = AuthLink(
      getToken: () async {
        return "access_token=$token";
      }, headerKey: 'Cookie'
    );
    GraphQLConfiguration.link = alink.concat(GraphQLConfiguration.httpLink as Link);
    
  }

  static void removeToken() {
    GraphQLConfiguration.link = null;
  }

  static Link? getLink() {
    print(GraphQLConfiguration.link ?? GraphQLConfiguration.httpLink.uri);
    print( GraphQLConfiguration.link == null ? "link null" : "link not null");
    return GraphQLConfiguration.link ?? GraphQLConfiguration.httpLink;
  }

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: getLink()!,
      cache: GraphQLCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );
  
  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(dataIdFromObject: typenameDataIdFromObject),
      link: getLink()!,
    );
  }

  void notify(){

    notifyListeners();
  }
}
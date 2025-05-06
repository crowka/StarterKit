//For the graphql.
import 'package:graphql/client.dart';

Map<String, String> apiConstants = {"auth": "https://reqres.in/api"};
GraphQLCache cache = GraphQLCache(
  dataIdFromObject: (object) {
    if (object is Map<String, Object> &&
        object.containsKey('__typename') &&
        object.containsKey('id')) {
      return "${object['__typename']}/${object['id']}";
    }
    return null;
  },
);

//For the rest.
// TODO: Consider moving GraphQLClient setup to a dedicated network service/helper in core/network/
GraphQLClient client() {
  final HttpLink _httpLink = HttpLink(
    'https://api.github.com/graphql',
  );

  final AuthLink _authLink = AuthLink(
    getToken: () => 'Bearer YOUR GITHUB ACCESS TOKEN', // TODO: Securely manage and inject access token
  );

  final Link _link = _authLink.concat(_httpLink);

  return GraphQLClient(
    cache: cache,
    link: _link,
  );
} 
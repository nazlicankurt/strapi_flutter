import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> initializeClient(String graphqlEndpoint) {
  final HttpLink httpLink = HttpLink(graphqlEndpoint);

  return ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );
}

const String strapiGraphQLURL = 'http://localhost:1337/graphql'; 
final graphqlClient = initializeClient(strapiGraphQLURL);

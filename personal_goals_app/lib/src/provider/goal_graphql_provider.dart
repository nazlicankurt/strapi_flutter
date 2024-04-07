import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:personal_goals_app/graphql_client.dart';

final graphqlClientProvider = Provider<GraphQLClient>((ref) {
  final ValueNotifier<GraphQLClient> client = graphqlClient; 
  return client.value;
});

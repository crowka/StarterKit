import 'dart:async';

import 'package:jump_off_platform/core/network/graphql_operations/mutations.dart' as mutations;
import 'package:jump_off_platform/core/network/graphql_operations/queries.dart' as queries;

import 'package:flutter/widgets.dart';
import 'package:gql/language.dart';
import 'package:graphql/client.dart';

class GraphqlQlHandler {
  final GraphQLClient client;

  // TODO: Consider using dependency injection (e.g. GetIt) to provide the GraphQLClient.
  GraphqlQlHandler({required this.client});

  Future<QueryResult> getRepositories(int numOfRepositories) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(queries.readRepositories), // Assuming readRepositories will be a string constant
      variables: <String, dynamic>{
        'nRepositories': numOfRepositories,
      },
      pollInterval: Duration(seconds: 4),
      fetchResults: true,
    );

    return await client.query(_options);
  }

  Future<QueryResult> toggleRepoStar(dynamic repo) async {
    // TODO: Define a proper type for 'repo' instead of dynamic.
    // TODO: Ensure viewerHasStarred and id are valid fields for the 'repo' type.
    var document =
        repo.viewerHasStarred ? mutations.removeStar : mutations.addStar; // Assuming these will be string constants

    final MutationOptions _options = MutationOptions(
      document: parseString(document),
      variables: <String, String>{
        'starrableId': repo.id,
      },
    );

    return await client.mutate(_options);
  }
} 
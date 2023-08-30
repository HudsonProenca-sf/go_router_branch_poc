import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_branch_poc/main.dart';

abstract class Routable {
  String get name;
  String get path;

  RoutableParams? hasValidParams(Map<String, String> queryParams);
}

abstract class RoutableParams {
  String toUrl();
  Widget toPage();
}

class UserProfileRoute implements Routable {
  @override
  final name = 'user profile';
  @override
  final path = 'user';

  UserProfileRoute();

  @override
  RoutableParams? hasValidParams(Map<String, String> params) {
    final userId = params['userId'];
    if (userId != null) {
      return UserProfileRouteParams(userId);
    }
    return null;
  }
}

class UserProfileRouteParams implements RoutableParams {
  final String userId;

  UserProfileRouteParams(this.userId);

  @override
  String toUrl() => Uri(
        path: '/user',
        queryParameters: _queryParams,
      ).toString();

  Map<String, Object> get _queryParams => {
        'userId': userId,
        'name': 'name',
        'email': 'email',
      };

  @override
  Widget toPage() {
    return UserScreen(
      userId: userId,
    );
  }
}

extension RoutableRoute on BuildContext {
  void goToRoute(RoutableParams route) {
    return go(route.toUrl());
  }
}

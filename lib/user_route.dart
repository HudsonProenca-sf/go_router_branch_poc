import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_branch_poc/main.dart';
import 'package:go_router_branch_poc/routes.dart';

class UserParams {
  final String userId;

  UserParams(this.userId);
}

class UserRouteParams extends AppRouteParameters<UserParams> {
  @override
  bool hasValidParams(Map<String, String> params) {
    return params['userId'] != null;
  }

  @override
  UserParams pathParamsFromMap(Map<String, String> params) =>
      UserParams(params['userId'] as String);

  @override
  Widget toPage(UserParams params) {
    return UserScreen(
      userId: params.userId,
    );
  }

  @override
  String toUriString(UserParams params) => '/users/${params.userId}';
}

class UserRouteConfiguration extends AppRouteConfiguration<UserRouteParams> {
  @override
  String get name => 'user';

  @override
  String get path => 'users/:userId';

  @override
  UserRouteParams get params => UserRouteParams();
}

class UserRoute extends AppRoute {
  UserRoute() : super(configuration: UserRouteConfiguration());

  void goToRoute(BuildContext context, UserParams params) {
    context.go(configuration.params.toUriString(params));
  }
}

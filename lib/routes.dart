import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

mixin Routable {
  String toUrl();
}

class UserProfileRouteParms implements Routable {
  static const route = 'users/:userId';
  final String userId;
  UserProfileRouteParms(this.userId);

  static hasValidParams(Map<String, String> params) {
    return params.containsKey('userId');
  }

  @override
  String toUrl() => '/users/$userId';
}

extension RoutableRoute on BuildContext {
  void goToRoute(Routable route) {
    return go(route.toUrl());
  }
}

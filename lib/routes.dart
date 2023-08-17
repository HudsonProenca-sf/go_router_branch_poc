import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

mixin AnalyticsRoute on RouteConfiguration {
  String get analyticsName;
}

abstract class AppRouteParameters<T> {
  T pathParamsFromMap(Map<String, String> params);
  bool hasValidParams(Map<String, String> params);

  String toUriString(T params);
  Widget toPage(T params);
}

abstract class AppRouteConfiguration<AppRouteParameters> {
  AppRouteParameters get params;
  String get name;
  String get path;
}

abstract class AppRoute<T> extends GoRoute {
  final AppRouteConfiguration<AppRouteParameters<T>> configuration;

  AppRoute({
    required this.configuration,
    super.redirect,
    super.parentNavigatorKey,
    super.routes,
  }) : super(
            path: configuration.path,
            name: configuration.name,
            builder: (_, state) {
              final hasValidParams =
                  configuration.params.hasValidParams(state.pathParameters);

              if (!hasValidParams) {
                // redirect
              }

              final params =
                  configuration.params.pathParamsFromMap(state.pathParameters);

              return configuration.params.toPage(params);
            });
}

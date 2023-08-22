
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_branch_poc/main.dart';
import 'package:go_router_branch_poc/routes.dart';

class OrganizationParams {
  final String orgId;

  OrganizationParams(this.orgId);
}

class OrganizationRouteParams extends AppRouteParameters<OrganizationParams> {
  @override
  bool hasValidParams(Map<String, String> params) {
    return params['orgId'] != null;
  }

  @override
  OrganizationParams pathParamsFromMap(Map<String, String> params) =>
      OrganizationParams(params['orgId'] as String);

  @override
  Widget toPage(OrganizationParams params) {
    return OrganizationScreen(
      id: params.orgId,
      params: const {},
    );
  }

  @override
  String toUriString(OrganizationParams params) =>
      '/organizations/${params.orgId}';
}

class OrganizationRouteConfiguration
    extends AppRouteConfiguration<OrganizationRouteParams> {
  @override
  String get name => 'organization';

  @override
  String get path => 'organizations/:orgId';

  @override
  OrganizationRouteParams get params => OrganizationRouteParams();
}

class OrganizationRoute extends AppRoute {
  OrganizationRoute() : super(configuration: OrganizationRouteConfiguration());

  void goToRoute(BuildContext context, OrganizationParams params) {
    context.go(configuration.params.toUriString(params));
  }
}

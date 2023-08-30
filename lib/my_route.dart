import 'package:go_router/go_router.dart';
import 'package:go_router_branch_poc/error_page.dart';
import 'package:go_router_branch_poc/routes.dart';

class MyRoute extends GoRoute {
  final Routable route;
  MyRoute({
    required this.route,
    super.parentNavigatorKey,
    super.redirect,
    super.routes = const <RouteBase>[],
  }) : super(
          name: route.name,
          path: route.path,
          builder: (context, state) {
            final routeParams = route.hasValidParams(state.uri.queryParameters);
            return routeParams?.toPage() ?? const ErrorPage();
          },
        );
}

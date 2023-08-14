import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_branch_poc/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterBranchSdk.validateSDKIntegration();
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: UserProfileRouteParms.route,
          builder: (BuildContext context, GoRouterState state) {
            if (UserProfileRouteParms.hasValidParams(state.pathParameters)) {
              return UserScreen(userId: state.pathParameters['userId']!);
            } else {
              return const ErrorScreen();
            }
          },
        ),
        GoRoute(
          path: 'organizations/:orgId',
          builder: (BuildContext context, GoRouterState state) {
            return OrganizationScreen(
              id: state.pathParameters['orgId']!,
              params: state.uri.queryParameters,
            );
          },
          routes: [
            GoRoute(
              path: 'members/:memberId',
              builder: (context, state) => MemberScreen(
                id: state.pathParameters['memberId']!,
              ),
              routes: [
                GoRoute(
                  path: 'projects/:projectId',
                  builder: (context, state) =>
                      ProjectsScreen(id: state.pathParameters['projectId']!),
                )
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

/// The home screen
class HomeScreen extends StatefulWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    FlutterBranchSdk.initSession().listen(
      (data) {
        print(data);
        if (data['+clicked_branch_link'] == true &&
            data[r'$deeplink_path'] != null) {
          context.go(data[r'$deeplink_path']);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go(UserProfileRouteParms('123').toUrl()),
              child: const Text('User'),
            ),
            ElevatedButton(
              onPressed: () => context.goToRoute(UserProfileRouteParms('234')),
              child: const Text('User2'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/organizations/1'),
              child: const Text('Organizations'),
            ),
            ElevatedButton(
              onPressed: () =>
                  context.go('/organizations/2/members/4?filter=456'),
              child: const Text('Organizations + members'),
            ),
            ElevatedButton(
              onPressed: () =>
                  context.go('/organizations/2/members/4/projects/mgmresorts'),
              child: const Text('Organizations + members + projects'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/org'),
              child: const Text('Unregistered page'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserScreen extends StatelessWidget {
  final String userId;

  const UserScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Screen')),
      body: Center(
        child: Text('User: $userId'),
      ),
    );
  }
}

class OrganizationScreen extends StatelessWidget {
  const OrganizationScreen({super.key, required this.id, required this.params});

  final String id;
  final Map<String, String> params;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Organization Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Org: $id'),
            ...params.entries.map((e) => Text('${e.key} - ${e.value}'))
          ],
        ),
      ),
    );
  }
}

class MemberScreen extends StatelessWidget {
  const MemberScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Member Screen')),
      body: Center(child: Text('Member $id')),
    );
  }
}

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects Screen')),
      body: Center(child: Text('Project $id')),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error Screen')),
      body: const Center(
        child: Text(
          "We couldn't find the page you're looking for",
        ),
      ),
    );
  }
}

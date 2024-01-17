import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jolly_pairs/app/app_reporter.dart';
import 'package:jolly_pairs/app/app_routing.dart';
import 'package:jolly_pairs/app/widget/app_global_error_dialog.dart';
import 'package:jolly_pairs/util/hook/use_async_stream_subscription.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils.dart';

class App extends HookWidget {
  static void run() {
    runWithReporterAndUiErrors(appReporter, (uiErrors) {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(App(uiErrors: uiErrors));
    });
  }

  final Stream<UiGlobalError> uiErrors;

  const App({super.key, required this.uiErrors});

  @override
  Widget build(BuildContext context) {
    final navigatorKey = useMemoized(GlobalKey<NavigatorState>.new);

    return _buildApp(
      navigatorKey: navigatorKey,
      builder: (context, child) => HookBuilder(builder: (context) {
        useAsyncStreamSubscription<UiGlobalError>(
          uiErrors,
          (error) async => _handleUiError(context, error, navigatorKey.currentState!),
        );
        return child;
      }),
    );
  }

  Widget _buildApp({
    required GlobalKey<NavigatorState> navigatorKey,
    required Widget Function(BuildContext context, Widget child) builder,
  }) {
    return MaterialApp(
      // theming
      scrollBehavior: const MaterialScrollBehavior().copyWith(physics: const BouncingScrollPhysics()),
      // navigation
      navigatorKey: navigatorKey,
      onGenerateInitialRoutes: (name) => [RouteConfig.generateInitialRoute(AppRouting.routes, name)],
      onGenerateRoute: (settings) => RouteConfig.generateRoute(AppRouting.routes, settings),
      navigatorObservers: [RouteConfig.createNavigationObserver(AppRouting.routes)],
      initialRoute: AppRouting.initialRoute,
      // localization
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      // other
      debugShowCheckedModeBanner: false,
      builder: (context, child) => builder(context, child!),
    );
  }

  Future<void> _handleUiError(BuildContext context, UiGlobalError error, NavigatorState navigator) async {
    // skip debug-time assertion errors
    if (error.error is! AssertionError) {
      final route = DialogRoute<void>(
        context: context,
        builder: (context) => AppGlobalErrorDialog(error: error),
      );
      await navigator.push(route);
    }
  }
}

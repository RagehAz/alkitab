import 'package:alkitab/c_protocols/a_bldrs_engine/bldrs_engine.dart';
import 'package:alkitab/c_protocols/providers/alkitab_pro.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/b_screens/0_logo_screen/logo_screen.dart';
import 'package:bldrs/b_screens/a_home_screen/the_home_screen.dart';
import 'package:bldrs/b_screens/x_situational_screens/banner_screen.dart';
import 'package:bldrs/c_protocols/a_bldrs_engine/bldrs_engine.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/animators/app_scroll_behavior.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/wire/wire.dart';
import 'package:universal_html/html.dart';


// ---------------------------------------------------------------------------

Future<void> main() => AlKitabEngine.mainIgnition();

// ---------------------------------------------------------------------------

final Wire<Locale?> superLocale = Wire<Locale?>(null);

class AppStarter extends StatefulWidget {
  // --------------------------------------------------------------------------
  const AppStarter({
    super.key
  });
  // --------------------
  static void setLocale(BuildContext? context, Locale? locale) {
    superLocale.value = null;
    superLocale.value = locale;
  }
  // --------------------
  @override
  _AppStarterState createState() => _AppStarterState();
// --------------------------------------------------------------------------
}

class _AppStarterState extends State<AppStarter> with WidgetsBindingObserver {
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    AlKitabEngine.appStartPreInit(
      observer: this,
    );

    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await AlKitabEngine.appStartInit();

      });
    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {

    AlKitabEngine.appStartDispose(
      observer: this,
    );

    super.dispose();
  }
  // --------------------
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    AlKitabEngine.appLifeCycleListener(state);
    super.didChangeAppLifecycleState(state);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return AlKitabProviders(
      child: SingleWire<Locale?>(
          wire: superLocale,
          builder: (Locale? locale) {

            locale ??= Localizer.getSupportedLocales().first;

            return SafeArea(
              child: MaterialApp(
                /// KEYS
                // key: ,
                // scaffoldMessengerKey: ,
                // restorationScopeId: ,
                // useInheritedMediaQuery: true,

                /// DUNNO
                // actions: ,

                // builder: DevicePreview.appBuilder,
                // home: ,
                // useInheritedMediaQuery: ,
                // shortcuts: ,
                scrollBehavior: const AppScrollBehavior(),

                /// DEBUG
                debugShowCheckedModeBanner: false,
                // debugShowMaterialGrid: false,
                // showPerformanceOverlay: false,
                // checkerboardRasterCacheImages: false,
                // showSemanticsDebugger: ,
                // checkerboardOffscreenLayers: ,

                /// THEME
                title: 'Al Kitab',
                // onGenerateTitle: ,
                // color: ,
                // darkTheme: ,
                // highContrastDarkTheme: ,
                // highContrastTheme: ,
                // themeMode: ,
                theme: ThemeData(
                  canvasColor: Colorz.nothing,
                  textSelectionTheme: const TextSelectionThemeData(
                    selectionHandleColor: Colorz.yellow255,
                    selectionColor: Colorz.white50,
                  ),
                ),

                /// LOCALE
                locale: locale,
                supportedLocales: Localizer.getSupportedLocales(),
                localizationsDelegates: Localizer.getLocalizationDelegates(),
                localeResolutionCallback: Localizer.localeResolutionCallback,
                // localeListResolutionCallback: ,
                /// ROUTES
                // navigatorObservers: [],
                // onGenerateInitialRoutes: ,
                // onUnknownRoute: ,
                // home: ,
                navigatorKey: mainNavKey,
                onGenerateRoute: AlKitabRouting.router,
                // initialRoute: RouteName.staticLogo,
                // routes: Routing.routesMap,
              ),
            );

          }
      ),
    );

  }
// -----------------------------------------------------------------------------
}

// ---------------------------------------------------------------------------

class AlKitabRouting {
  // -----------------------------------------------------------------------------

  const AlKitabRouting();

  // -----------------------------------------------------------------------------

  /// ROUTER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Route<dynamic> router(RouteSettings settings) {
    String? _path;
    String? _arg;

    if (kIsWeb){
      final String _url = window.location.toString();
      _path = RoutePather.getPathFromWindowURL(_url);
      _arg = RoutePather.getArgFromWindowURL(_url);
    }
    else {
      _path = RoutePather.getPathFromRouteSettingsName(settings.name);
      _arg = RoutePather.getArgFromRouteSettingsName(settings.name);
    }

    blog('router : _path($_path) : _arg($_arg) ');

    switch (_path) {
      case ScreenName.logo:
        return Nav.transitFade(
          screen: BldrsEngine.deadWeb ? const BannerScreen() : const LogoScreen(),
          settings: settings,
        );
      case ScreenName.home:
        return Nav.transitFade(
          screen: const TheHomeScreen(),
          settings: settings,
        );
      default:
        return Nav.transitFade(
          // screen: const NoPageFoundScreen(),
          screen: const TheHomeScreen(),
          settings: settings,
        );
    // ------------------------------------------------------------
    }

  }
  // -----------------------------------------------------------------------------

  /// AUTO NAV

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> restartToAfterHomeRoute({
    required String? routeName,
    String? arguments,
  }) async {

    if (TextCheck.isEmpty(routeName) == false){

      if (mainNavKey.currentContext == null){
        await Future.delayed(const Duration(seconds: 3));
      }

      UiPro.proSetAfterHomeRoute(
          routeName: routeName,
          arguments: arguments,
          notify: true
      );

      await Routing.goTo(route: ScreenName.logo);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> autoNavigateToAfterHomeRoute({
    required bool mounted,
  }) async {

    if (mounted == true){

      final RouteSettings? _afterHomeRoute = UiPro.proGetAfterHomeRoute();

      if (_afterHomeRoute != null){

        /// CLEAR AFTER HOME ROUTE
        UiPro.proClearAfterHomeRoute(
          notify: true,
        );

        final String? _args = _afterHomeRoute.arguments as String?;

        await Routing.goTo(
          route: _afterHomeRoute.name,
          arg: _args,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------
}

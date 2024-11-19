part of alkitab_engine;
/// => TAMAM
class AlKitabEngine {
  // --------------------------------------------------------------------------

  const AlKitabEngine();

  // --------------------------------------------------------------------------
  static const bool useSentryOnDebug = false;
  static const bool _runSentry = false; // useSentryOnDebug == true ? true : !kDebugMode;
  // --------------------------------------------------------------------------

  /// MAIN

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> mainIgnition() async {
    // -----------------------------------------------------------------------------
    /// PLAN : In optimization : study this : https://pub.dev/packages/keframe
    // --------------------
    _report(invoker: 'A.mainIgnition', number: 1, text: 'START');
    // --------------------
    if (_runSentry == true){
      // await Sentrize.initializeApp(
      //   app: const BldrsAppStarter(),
      //   dns: AlKitabKeys.sentryDSN,
      //   functions: (WidgetsBinding binding) async {
      //     // --------------------
      //     await initializeBldrs(binding);
      //     // --------------------
      //   },
      // );
    }
    // --------------------
    else {
      // --------------------
      final WidgetsBinding _binding = WidgetsFlutterBinding.ensureInitialized();
      await initializeApp(_binding);
      // --------------------
      runApp(const AppStarter());
      // --------------------
    }
    // --------------------
    _report(invoker: 'A.mainIgnition', number: 2, text: 'END');
    // -----------------------------------------------------------------------------
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> initializeApp(WidgetsBinding binding) async {
    // --------------------
    final bool _isSmartPhone = DeviceChecker.deviceIsSmartPhone();
    // --------------------
    _report(invoker: 'B.initializeBldrs', number: 1, text: 'will preserve splash(${kIsWeb == false})');
    if (kIsWeb == false) {
      FlutterNativeSplash.preserve(widgetsBinding: binding);
    }
    // --------------------
    _report(invoker: 'B.initializeBldrs', number: 2, text: 'Initializing fire');
    await OfficialFirebase.initialize(
      // useOfficialPackages: !DeviceChecker.deviceIsWindows(),
      socialKeys: AlKitabKeys.socialKeys,
      options: DefaultFirebaseOptions.currentPlatform,
      // realForceOnlyAuthenticated: true,
      // nativePersistentStoragePath: ,
    );
    // --------------------
    _report(invoker: 'B.initializeBldrs', number: 3, text: 'will Initializing fire messaging ($_isSmartPhone)');
    // if (_isSmartPhone == true){
    //   FirebaseMessaging.onBackgroundMessage(pushRemoteListenerForBldrsApp);
    // }
    // --------------------
    // _report(invoker: 'B.initializeBldrs', number: 4, text: 'will initializing noot ($_isSmartPhone)');
    // _report(invoker: 'B.initializeBldrs', number: 5, text: 'initializing App check');
    // await Future.wait(<Future>[
    //
    //   // /// FCM
    //   // if (_isSmartPhone == true)
    //   //   PushInit.initAwesome(),
    //
    //   // /// APP CHECK
    //   // AppCheck.preInitialize(),
    //
    //   /// GOOGLE ADS
    //   // GoogleAds.initialize(),
    //
    // ]);
    // --------------------
  }
  // --------------------------------------------------------------------------

  /// APP STARTER

  // --------------------
  /// TESTED : WORKS PERFECT
  static void appStartPreInit({
    required WidgetsBindingObserver observer,
  }){
    /// NOTE : No providers can be initialized here

    blog('XXX === >>> APP START');

    _report(invoker: 'C.appStartPreInit', number: 1, text: 'will remove splash(${kIsWeb == false})');
    /// NATIVE SPLASH SCREEN
    if (kIsWeb == false){
      FlutterNativeSplash.remove();
    }

    _report(invoker: 'C.appStartPreInit', number: 2, text: 'Adding observer');
    /// WIDGET BINDING OBSERVER
    WidgetsBinding.instance.addObserver(observer);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> appStartInit() async {

    // _report(invoker: 'D.appStartInit', number: 1, text: 'Initializing noots');

    // /// INITIALIZE
    // await PushInit.initPush();

    // _report(invoker: 'D.appStartInit', number: 2, text: 'Initializing noots done');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void appStartDispose({
    required WidgetsBindingObserver observer,
  }){
    // Sembast.dispose(); async function,, and no need to close sembast I guess
    // _closeNootListeners();
    Sounder.dispose();
    // PushInstance.disposeAwesome();
    WidgetsBinding.instance.removeObserver(observer);
    superLocale.dispose();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void appLifeCycleListener(AppLifecycleState state){

    if (state == AppLifecycleState.resumed) {
      blog('XXX === >>> RESUMED');
    }
    else if (state == AppLifecycleState.inactive) {
      blog('XXX === >>> INACTIVE');
    }
    else if (state == AppLifecycleState.paused) {
      blog('XXX === >>> PAUSED');
    }
    else if (state == AppLifecycleState.detached) {
      blog('XXX === >>> DETACHED');
    }

  }
  // --------------------------------------------------------------------------

  /// LOGO

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> logoScreenRouting({
    required bool mounted,
  }) async {

    _report(invoker: 'E.logoScreenRouting', number: 1, text: 'will start logo scree ($mounted) : kIsWeb($kIsWeb)');

    if (mounted == true){

      // /// MOBILE - WINDOWS
      // if (kIsWeb == false){
      //   await Routing.goTo(route: ScreenName.home);
      // }
      //
      // /// WEB : WHERE THERE IS A URL
      // else {
      //
      //   final String _url = window.location.toString();
      //
      //   final String? _path = RoutePather.getPathFromWindowURL(_url);
      //
      //   /// LANDED ON LOGO SCREENS OR ON HOME SCREEN
      //   if (_path == ScreenName.logo || _path == ScreenName.home){
      //     await Routing.goTo(route: ScreenName.home);
      //   }
      //
      //   else {
      //
      //     final String? _routeSettingsName = RoutePather.getRouteSettingsNameFromFullPath(_url);
      //
      //     await Routing.restartToAfterHomeRoute(
      //       routeName: RoutePather.getPathFromRouteSettingsName(_routeSettingsName),
      //       arguments: RoutePather.getArgFromRouteSettingsName(_routeSettingsName),
      //     );
      //
      //   }
      //
      // }

    }

  }
  // --------------------------------------------------------------------------

  /// HOME

  // --------------------
  /// TESTED : WORKS PERFECT
  static void homePreInit({
    required TickerProvider vsync,
  }){

    final bool _canPreInitHome = ProCanStartHome.checkCanPreInit();

    if (_canPreInitHome == true){

      ProCanStartHome.setPreInit(setTo: false);

      _report(invoker: 'F.initNavController', number: 1, text: 'NAV CONTROLLER');

      /// NAV CONTROLLER
      HomePro.initNavController(vsync);
      /// HOME CONTROLLER
      HomePro.preInitHomeController();

      _report(invoker: 'F.homePreInit', number: 2, text: 'DOING KEYBOARD');

      /// KEYBOARD
      UiPro.proInitializeKeyboard();

      _report(invoker: 'F.homePreInit', number: 3, text: 'Home grid');

      /// HOME GRID
      ProHomePagination.init(
        vsync: vsync,
        mounted: true,
      );

      _report(invoker: 'F.homePreInit', number: 4, text: 'LAYOUT');

      /// LAYOUT IS VISIBLE
      UiPro.proSetLayoutIsVisible(
        setTo: true,
        notify: true,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> homeInit({
    required BuildContext context,
    required bool mounted,
  }) async {

    final bool _canInitHome = ProCanStartHome.checkCanInit();

    if (_canInitHome == true){

      ProCanStartHome.setCanInit(setTo: false);

      /// CLEAN SLATE PROTOCOL
      await CleanSlateProtocol.start();

      /// REFRESH LDB
      await UiInitializer.refreshLDB();

      /// CLOSE KEYBOARD
      await awaiter(
        wait: false,
        function: UiPro.closeKeyboard,
      );

      // /// USER
      // await UserInitializer.initialize();

      // /// ZONE
      // await ZonePro.proSetCurrentZone(
      //   zone: UserPro.proGetMyUserModel()?.zone?.countryID == 'egy' ? UserPro.proGetMyUserModel()!.zone! : ZoneModel.planetZone,
      // );

      /// APP LANGUAGE
      await UiInitializer.initializeAppLanguage(
        context: context,
        mounted: mounted,
      );

      // /// COUNTRIES PHRASES
      // await awaiter(
      //   wait: false,
      //   function: CountriesPhrasesProtocols.generateCountriesPhrases,
      // );


      await awaiter(
        wait: false,
        function: () async {
          /// APP STATE
          // await _AppStateInitializer.initialize();
          /// AUTO NAV
          await Routing.autoNavigateToAfterHomeRoute(mounted: mounted);
          /// APP LANGUAGE
          await UiInitializer.initializeClock(mounted: mounted);
        },
      );

      /// HOME INIT
      await HomePro.initHomeController();

      // /// BZ STREAMS
      // ProMyBzzStreams.proInitializeMyBzzStreams();

      // /// NOTIFICATIONS
      // await NotesPro.proInitializeNoteStreams(mounted: mounted);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void homeDispose(){
    if (kIsWeb == false){
      ProCanStartHome.setPreInit(setTo: true);
      ProCanStartHome.setCanInit(setTo: true);
      UiPro.disposeKeyword();
      ProHomePagination.dispose();
      // NotesPro.disposeNoteStreams();
      HomePro.disposeNavController();
      HomePro.disposeHomeController();
      // ProMyBzzStreams.proDisposeMyBzzStreams();
    }
  }
  // --------------------------------------------------------------------------

  /// TRACKING

  // --------------------
  static const bool _canReport = kDebugMode;
  // --------------------
  static void _report({
    required int number,
    required String text,
    required String invoker,
  }){
    if (_canReport == true){
      blog('$invoker($number): $text');
    }
  }
// --------------------------------------------------------------------------
}

/*

keytool -genkeypair -v -keystore D:\key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias myalias

keytool -list -v -keystore D:\projects\other\alkitab\android\app\key.jks -alias myalias



 */

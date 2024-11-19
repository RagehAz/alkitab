part of alkitab_engine;

/// => TAMAM
class UiInitializer {
  // -----------------------------------------------------------------------------

  const UiInitializer();

  // -----------------------------------------------------------------------------

  /// LOADING VERSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static void setLoadingVerse(String? text){
    UiPro.proSetLoadingVerse(verse: Verse.plain(text));
  }
  // -----------------------------------------------------------------------------

  /// APP LANGUAGE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> initializeAppLanguage({
    required BuildContext context,
    required bool mounted,
  }) async {

    String? _initialLang = UserPro.getPro().myUserModel?.language;

    if (_initialLang == null){
      _initialLang = await Localizer.readLDBLangCode();
      _initialLang ??= await Dialogs.languageDialog();
      _initialLang ??= 'en';
    }

    // await _reportLang(context);

    if (mounted == true){
      await Localizer.changeAppLanguage(
        code: _initialLang,
        context: context,
      );
    }

  }
  // --------------------
  /*
  static Future<void> _reportLang(BuildContext context) async {

    if (kDebugMode){
      final String? _ldb = await Localizer.readLDBLangCode();
      final String? _json = Localizer.getCurrentLangCode();
      final String? _user = UsersProvider.proGetMyUserModel(context: context, listen: false)?.language;
      await Dialogs.centerNotice(
        verse: Verse.plain('Local_Langs_report'),
        body: Verse.plain('ldb($_ldb) user($_user) json($_json)'),
      );
    }


  }
   */
  // -----------------------------------------------------------------------------

  /// CLOCK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> initializeClock({
    required bool mounted,
}) async {
    const bool _good = true;

    // const bool doTheClockCheck = false;
    //
    // if (mounted == true && doTheClockCheck == true){
    //
    //     /// CHECK DEVICE CLOCK
    //     bool _deviceTimeIsCorrect = await BldrsTimers.checkDeviceTimeIsCorrect(
    //       showIncorrectTimeDialog: true,
    //       canThrowError: true,
    //     );
    //
    //     /// OVERRIDE : FOR WEB AND WINDOWS
    //     if (
    //         _deviceTimeIsCorrect == true ||
    //         kIsWeb == true ||
    //         DeviceChecker.deviceIsWindows() == true
    //     ){
    //       _good = true;
    //     }
    //     else {
    //
    //       await Future.delayed(const Duration(seconds: 5));
    //
    //       _deviceTimeIsCorrect = await BldrsTimers.checkDeviceTimeIsCorrect(
    //         showIncorrectTimeDialog: false,
    //         canThrowError: false,
    //       );
    //
    //       if (_deviceTimeIsCorrect == true){
    //         _good = true;
    //       }
    //
    //       else {
    //         await Routing.goTo(route: ScreenName.logo);
    //         _good = false;
    //       }
    //
    //     }
    //
    // }

    return _good;
  }
  // -----------------------------------------------------------------------------

  /// SCREEN DIM - ICONS - PHRASES

  // --------------------
  // /// TESTED : WORKS PERFECT
  // static Future<void> initializeIconsAndPhrases() async {
  //
  //
  //
  //
  //
  //
  //   await Future.wait([
  //
  //     GeneralProvider.proGetSetLocalAssetsPaths(notify: true),
  //
  //     PhraseProtocols.generateCountriesPhrases(),
  //
  //   ]);
  //
  // }
  // -----------------------------------------------------------------------------

  /// LDB REFRESH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> refreshLDB() async {

    /// DEPRECATED
    // await TheLastWiper.monitorRefreshLDBThing();

    final bool _shouldRefresh = kDebugMode == true ? false : await TheLastWiper.checkShouldRefreshLDB(
      refreshDurationInMinutes: Standards.ldbWipeIntervalInMinutes,
    );

    if (_shouldRefresh == true){

      blog('WILL REFRESH THE FUCKING LLLLLLLLLLLLLDDDDDDDDDDDBBBBBBBBBBB');

      await Future.wait(<Future>[

        // Director.wipeAllDirectoriesAndCaches(),

        /// DELETE
        /// MODEL_OFTEN_UPDATES
        // KEEP_LAST_SESSIONS
        // NEVER_EVER_DELETE_MY_ACCOUNTS
        // NEVER_TOUCH_THIS
        // KEEP_REPO_FILES
        // NO_NEED_TO
        // DASH_BOARD_STUFF
        // UPDATED_ON_NEW_RELEASE_ONLY
        LDBDoc.wipeOutLDBDocs(
          flyers: true, /// MODEL_OFTEN_UPDATES
          pdfs: true, /// MODEL_OFTEN_UPDATES
          flyersMedias: true, /// MODEL_OFTEN_UPDATES
          reviewEditor: false, // KEEP_LAST_SESSIONS
          flyersCounters: true, /// MODEL_OFTEN_UPDATES
          fcDrafts: false, // KEEP_LAST_SESSIONS
          fcMedias: false, // KEEP_LAST_SESSIONS
          fcPDFs: false, // KEEP_LAST_SESSIONS
          fcVideoControllers: false, // KEEP_LAST_SESSIONS
          bzz: true, /// MODEL_OFTEN_UPDATES
          bzzAssets: false, // KEEP_REPO_FILES
          powers: false, // NO_NEED_TO
          bzzMedias: true, /// MODEL_OFTEN_UPDATES
          bzzCounters: true, /// MODEL_OFTEN_UPDATES
          fishes: false, // DASH_BOARD_STUFF
          fishMedias: false, // DASH_BOARD_STUFF
          fishReport: false, // DASH_BOARD_STUFF
          users: true, /// MODEL_OFTEN_UPDATES
          authModel: false, // NEVER_EVER_DELETE_MY_ACCOUNTS
          accounts: false, // NEVER_EVER_DELETE_MY_ACCOUNTS
          searches: false, // NO_NEED_TO
          usersMedias: true, /// MODEL_OFTEN_UPDATES
          usersCounters: true, /// MODEL_OFTEN_UPDATES
          // notes: true,
          // superFiles: true,
          stolenURLs: true, /// MODEL_OFTEN_UPDATES
          homePhid: false, // NO_NEED_TO
          phidsPics: false, // UPDATED_ON_NEW_RELEASE_ONLY
          keywords: false, // UPDATED_ON_NEW_RELEASE_ONLY
          zonePhids: true, /// MODEL_OFTEN_UPDATES
          keywordsPhrasesAreDownloaded: false, // NO_NEED_TO
          allKeywordsPhrasesInAllLangs: false, // UPDATED_ON_NEW_RELEASE_ONLY
          countries: false, // UPDATED_ON_NEW_RELEASE_ONLY
          cities: false, // UPDATED_ON_NEW_RELEASE_ONLY
          staging: true, /// MODEL_OFTEN_UPDATES
          census: true, /// MODEL_OFTEN_UPDATES
          countriesPhrases: false, // UPDATED_ON_NEW_RELEASE_ONLY
          theLastWipe: false, // NEVER_TOUCH_THIS
          ldbVersion: false, // NEVER_TOUCH_THIS
          deviceRefreshed: false, // NEVER_TOUCH_THIS
          langCode: false, // NEVER_EVER_DELETE_MY_ACCOUNTS
          onboarding: false, // NEVER_EVER_DELETE_MY_ACCOUNTS
          gta: false, // DASH_BOARD_STUFF
          facebookToken: false, // DASH_BOARD_STUFF
          gtiRecords: false, // DASH_BOARD_STUFF
          repoInstaProfiles: false, // DASH_BOARD_STUFF
          webpages: false, // DASH_BOARD_STUFF
          noteCampaigns: false, // DASH_BOARD_STUFF
          userEditor: false, // KEEP_LAST_SESSIONS
          bzEditor: false, // KEEP_LAST_SESSIONS
          authorEditor: false, // KEEP_LAST_SESSIONS
          flyerMaker: false, // KEEP_LAST_SESSIONS
        ),

      ]);

    }

  }

  // -----------------------------------------------------------------------------

  /// ONBOARDING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> initializeOnBoarding({
    required bool mounted,
  }) async {

    if (mounted == true){

      // final bool autoOnBoardingIsActive = await OnBoardingScreen.autoOnBoardingIsActive();
      //
      //   if (autoOnBoardingIsActive == true){
      //
      //     await OnBoardingScreen.goToOnboardingScreen(
      //       showDontShowAgainButton: true,
      //     );
      //
      //   }

    }

  }
  // -----------------------------------------------------------------------------
}

// ignore_for_file: always_put_control_body_on_new_line
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/ldb/ldb.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/foundation.dart';

/*

WHEN YOU ADD NEW LDB DOC

1. add ldbDoc name as static const String in below (DOCS) section
2. add in getPrimaryKey()
3. add in <String>[allDocs]
4. add in LDBOps.wipeOutEntireLDB()
          &
          logo_screen_controller._dailyRefreshLDB()
          &
          logo_screen_controller._refreshUserDeviceModel()

 */
/// ldb_doc_
class LDBDoc {
  // -----------------------------------------------------------------------------

  const LDBDoc();

  // -----------------------------------------------------------------------------
  static const List<String> _forbiddenLDBDocs = [
  ];


  // --------------------
  /// USERS
  static const String users = 'users';
  static const String authModel = 'authModel';
  static const String accounts = 'accounts';
  static const String usersMedias = 'usersMedias';


  // --------------------
  /// SETTINGS
  static const String theLastWipe = 'theLastWipeMap';
  static const String ldbVersion = 'ldbVersion';
  static const String deviceRefreshed = 'deviceRefreshed';
  static const String langCode = 'langCode';
  static const String onboarding = 'onboarding';
  // -----------------------------------------------------------------------------

  /// ALL DOCS LIST

  // --------------------
  static const List<String> allDocs = <String>[
    // --------------------
    'headline: USERS',
    users,
    authModel,
    accounts,
    usersMedias,
    // --------------------
    'headline: SETTINGS',
    theLastWipe,
    ldbVersion,
    deviceRefreshed,
    langCode,
    onboarding,
  ];
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeOutLDBDocs({
    bool? flyers,
    bool? pdfs,
    bool? flyersMedias,
    bool? reviewEditor,
    bool? flyersCounters,
    bool? fcDrafts,
    bool? fcMedias,
    bool? fcPDFs,
    bool? fcVideoControllers,
    bool? bzz,
    bool? bzzAssets,
    bool? powers,
    bool? bzzMedias,
    bool? bzzCounters,
    bool? fishes,
    bool? fishMedias,
    bool? fishReport,
    bool? users,
    bool? authModel,
    bool? accounts,
    bool? searches,
    bool? usersMedias,
    bool? usersCounters,
    bool? stolenURLs,
    bool? homePhid,
    bool? phidsPics,
    bool? keywords,
    bool? zonePhids,
    bool? keywordsPhrasesAreDownloaded,
    bool? treeState,
    bool? allKeywordsPhrasesInAllLangs,
    bool? countries,
    bool? cities,
    bool? staging,
    bool? census,
    bool? countriesPhrases,
    bool? theLastWipe,
    bool? ldbVersion,
    bool? deviceRefreshed,
    bool? langCode,
    bool? onboarding,
    bool? gta,
    bool? facebookToken,
    bool? gtiRecords,
    bool? repoInstaProfiles,
    bool? webpages,
    bool? noteCampaigns,
    bool? userEditor,
    bool? bzEditor,
    bool? authorEditor,
    bool? flyerMaker,
  }) async {

    List<String> _docs = <String>[];

    if(Mapper.boolIsTrue(users                        ) == true){_docs.add(LDBDoc.users);}
    if(Mapper.boolIsTrue(authModel                    ) == true){_docs.add(LDBDoc.authModel);}
    if(Mapper.boolIsTrue(accounts                     ) == true){_docs.add(LDBDoc.accounts);}
    if(Mapper.boolIsTrue(usersMedias                  ) == true){_docs.add(LDBDoc.usersMedias);}
    if(Mapper.boolIsTrue(theLastWipe                  ) == true){_docs.add(LDBDoc.theLastWipe);}
    if(Mapper.boolIsTrue(ldbVersion                   ) == true){_docs.add(LDBDoc.ldbVersion);}
    if(Mapper.boolIsTrue(deviceRefreshed              ) == true){_docs.add(LDBDoc.deviceRefreshed);}
    if(Mapper.boolIsTrue(langCode                     ) == true){_docs.add(LDBDoc.langCode);}
    if(Mapper.boolIsTrue(onboarding                   ) == true){_docs.add(LDBDoc.onboarding);}

    final bool _canWipe = await _debugReport(
      docs: _docs,
    );

    if (_canWipe == true){

      /// OLD ARTEFACTS SHOULD BE WIPED
      _docs = _addOldArtifactsToDelete(docs: _docs);

      await _wipeDocs(
        canWipe: _canWipe,
        docs: _docs,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _debugReport({
    required List<String> docs,
  }) async {
    bool? _wipe = true;

    if (kDebugMode && Lister.checkCanLoop(docs) == true){
      String _paragraph = '';
      for (int i = 0; i < docs.length; i++){
        _paragraph = '$_paragraph$i : ${docs[i]}\n';
      }
      _wipe = await Dialogs.paragraphDialog(
        paragraphCentered: false,
        title: Verse.plain('Debug Wiping LDB'),
        body: Verse.plain('Wiping ${docs.length} docs'),
        paragraph: Verse.plain(_paragraph),
      );
    }

    return _wipe ??= true;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _wipeDocs({
    required List<String> docs,
    required bool canWipe,
  }) async {

    if (canWipe == true){
      await Future.wait(<Future>[
        ...List.generate(docs.length, (index){
          return LDBOps.deleteAllMapsAtOnce(
            docName: docs[index],
          );
        }),
      ]);
    }

  }
  // --------------------
  static Future<void> onLightRebootSystem() async {

    /// DELETE
    /// MODEL_OFTEN_UPDATES
    // KEEP_LAST_SESSIONS
    // NEVER_EVER_DELETE_MY_ACCOUNTS
    // NEVER_TOUCH_THIS
    // KEEP_REPO_FILES
    // NO_NEED_TO
    // DASH_BOARD_STUFF
    // UPDATED_ON_NEW_RELEASE_ONLY

    await wipeOutLDBDocs(
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
      powers: true, /// MODEL_OFTEN_UPDATES
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
      stolenURLs: true, /// MODEL_OFTEN_UPDATES
      homePhid: false, // NO_NEED_TO
      treeState: false, // NO_NEED_TO
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
    );

  }
  // --------------------
  static Future<void> onHardRebootSystem() async {

    /// DELETE
    /// 1. MODEL_OFTEN_UPDATES
    /// 2. DELETE_LAST_SESSIONS
    /// 3. DELETE_REPO_FILES
    /// 4. DASH_BOARD_STUFF
    /// 5. NO_NEED_TO
    /// 6. UPDATED_ON_NEW_RELEASE_ONLY
    // KEEP
    // NEVER_EVER_DELETE_MY_ACCOUNTS
    // NEVER_TOUCH_THIS

    await wipeOutLDBDocs(
      flyers: true, /// MODEL_OFTEN_UPDATES
      pdfs: true, /// MODEL_OFTEN_UPDATES
      flyersMedias: true, /// MODEL_OFTEN_UPDATES
      reviewEditor: true, /// DELETE_LAST_SESSIONS
      flyersCounters: true, /// MODEL_OFTEN_UPDATES
      fcDrafts: true, /// DELETE_LAST_SESSIONS
      fcMedias: true, /// DELETE_LAST_SESSIONS
      fcPDFs: true, /// DELETE_LAST_SESSIONS
      fcVideoControllers: true, /// DELETE_LAST_SESSIONS
      bzz: true, /// MODEL_OFTEN_UPDATES
      bzzAssets: true, /// DELETE_REPO_FILES
      powers: true, /// MODEL_OFTEN_UPDATES
      bzzMedias: true, /// MODEL_OFTEN_UPDATES
      bzzCounters: true, /// MODEL_OFTEN_UPDATES
      fishes: true, /// DASH_BOARD_STUFF
      fishMedias: true, /// DASH_BOARD_STUFF
      fishReport: true, /// DASH_BOARD_STUFF
      users: true, /// MODEL_OFTEN_UPDATES
      authModel: false, // NEVER_EVER_DELETE_MY_ACCOUNTS
      accounts: false, // NEVER_EVER_DELETE_MY_ACCOUNTS
      searches: true, /// NO_NEED_TO
      usersMedias: true, /// MODEL_OFTEN_UPDATES
      usersCounters: true, /// MODEL_OFTEN_UPDATES
      stolenURLs: true, /// MODEL_OFTEN_UPDATES
      homePhid: true, /// NO_NEED_TO
      treeState: true, /// NO_NEED_TO
      phidsPics: true, /// UPDATED_ON_NEW_RELEASE_ONLY
      keywords: true, /// UPDATED_ON_NEW_RELEASE_ONLY
      zonePhids: true, /// MODEL_OFTEN_UPDATES
      keywordsPhrasesAreDownloaded: true, /// NO_NEED_TO
      allKeywordsPhrasesInAllLangs: true, /// UPDATED_ON_NEW_RELEASE_ONLY
      countries: true, /// UPDATED_ON_NEW_RELEASE_ONLY
      cities: true, /// UPDATED_ON_NEW_RELEASE_ONLY
      staging: true, /// MODEL_OFTEN_UPDATES
      census: true, /// MODEL_OFTEN_UPDATES
      countriesPhrases: true, /// UPDATED_ON_NEW_RELEASE_ONLY
      theLastWipe: false, // NEVER_TOUCH_THIS
      ldbVersion: false, // NEVER_TOUCH_THIS
      deviceRefreshed: false, // NEVER_TOUCH_THIS
      langCode: false, // NEVER_EVER_DELETE_MY_ACCOUNTS
      onboarding: false, // NEVER_EVER_DELETE_MY_ACCOUNTS
      gta: true, /// DASH_BOARD_STUFF
      facebookToken: true, /// DASH_BOARD_STUFF
      gtiRecords: true, /// DASH_BOARD_STUFF
      repoInstaProfiles: true, /// DASH_BOARD_STUFF
      webpages: true, /// DASH_BOARD_STUFF
      noteCampaigns: true, /// DASH_BOARD_STUFF
      userEditor: true, /// DELETE_LAST_SESSIONS
      bzEditor: true, /// DELETE_LAST_SESSIONS
      authorEditor: true, /// DELETE_LAST_SESSIONS
      flyerMaker: true, /// DELETE_LAST_SESSIONS
    );

  }
  // --------------------
  /// FORBIDDEN_LDB_DOCS
  static List<String> _addOldArtifactsToDelete({
    required List<String> docs,
  }){
    return Stringer.addStringsToStringsIfDoNotContainThem(
        listToTake: docs,
        listToAdd: _forbiddenLDBDocs,
    );
  }
  // -----------------------------------------------------------------------------
}

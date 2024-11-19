import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:flutter/material.dart';

class Standards {
  // -----------------------------------------------------------------------------

  const Standards();

  // -----------------------------------------------------------------------------
  /// WEB SITE
  // -------
  static String bldrsWebSiteURL = '';//'https://www.bldrs.net';
  // -------
  /// TERMS - PRIVACY URLs
  // -------
  static String termsAndRegulationsURL = '';//'https://www.bldrs.net/#/terms';
  static String privacyPolicyURL = '';//'https://www.bldrs.net/#/privacy';
  static String deleteMyDataURL = '';//'https://www.bldrs.net/#/deletemydata';
  // --------------------
  /// APP LINKS
  // -------
  static const String iosAppStoreURL = '';
  static const String androidAppStoreURL = '';//'https://play.google.com/store/apps/details?id=net.bldrs.alkitab';
  // -----------------------------------------------------------------------------
  /// SOCIAL MEDIA
  // -------
  static const String bldrsFacebookPageURL = ''; //'https://www.facebook.com/alkitab';
  static const String bldrsInstagramPageURL = '';// 'https://www.instagram.com/alkitab';
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getBldrsStoreLink(){

    String? _url;

    if (DeviceChecker.deviceIsIOS() == true){
      _url = iosAppStoreURL;
    }
    else if (DeviceChecker.deviceIsAndroid() == true){
      _url = androidAppStoreURL;
    }

    return _url;
  }
  // -----------------------------------------------------------------------------

  /// LOADING SCREEN

  // --------------------
  static const int loadingScreenTimeOut = 55;
  // -----------------------------------------------------------------------------

  /// EDITORS STANDARDS

  // --------------------
  static const int minUserNameLength = 5;
  static const int minJobTitleLength = 2;
  static const int minCompanyNameLength = 2;
  // -----------------------------------------------------------------------------

  /// FLYER_STANDARDS

  // --------------------
  static const int maxVideoDurationMs = 10 * 1000; // 15 seconds * 1000 milliSecond per second = 15'000 Ms
  static const int maxSlideVideoDurationSToPick = 30;
  // --------------------
  static const int flyerMaxDaysToUpdate = 3; // 3 days to update flyer
  // --------------------
  /// FLYER HEADLINE LENGTH
  static const int flyerHeadlineMaxLength = 200;
  /// this is paired to
  /// phid_flyer_headline_should_be_more_than_5_chars
  /// phid_flyer_headline_should_be_more_than_10_chars
  static const int flyerHeadlineMinLength = 5;
  // -----------------------------------------------------------------------------

  /// BZ STANDARDS

  // --------------------
  static const int maxUserBzz = 10;
  // static const int maxAuthorsPerBz = 20;
  static const int bzActivationTriggerCoolDownMinutes = 5;
  // -----------------------------------------------------------------------------

  /// USER RECORDS STANDARDS

  // --------------------
  static const int maxUserFollows = 5000;
  static const int maxUserSavedFlyers = 5000;
  // --------------------
  static const int countersRefreshTimeDurationInMinutes = 10;
  // -----------------------------------------------------------------------------

  /// CONTACTS STANDARDS

  // --------------------
  static bool bzPhoneIsMandatory = false;
  static bool bzWebsiteIsMandatory = false;
  // --------------------
  static bool authorPhoneIsMandatory = false;
  // -----------------------------------------------------------------------------

  /// OTHER STANDARDS

  // --------------------
  static const int maxTrigramLength = 5;
  static const int maxLocationFetchSeconds = 10;

  /// THIS IS USED TO TRIM PHID TEXT ON SCREEN TO AVOID OVERFLOW
  static const int maxPhidCharLengthBeforeTrim = 27;
  // -----------------------------------------------------------------------------

  /// SEARCH

  // --------------------
  static const int minSearchChar = 3;
  // -----------------------------------------------------------------------------

  /// FILE SIZES

  // --------------------
  static const int maxFileSizeLimit = 3; // in Mb
  // -----------------------------------------------------------------------------



  static const int ldbWipeIntervalInMinutes = 1440;



  // -----------------------------------------------------------------------------

  /// SLIDE ANIMATION CURVE

  // --------------------
  static const Curve slideAnimCurve = Curves.easeOutQuart;
  // -----------------------------------------------------------------------------

  /// POSTER SIZE

  // --------------------
  static const Dimensions posterDimensions = Dimensions(
    width: 720,
    height: 360,
  );
  // -----------------------------------------------------------------------------

  /// LOGO

  // --------------------
  /// BLDRS APP ICON
  static const String bldrsAppIconURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbldrs_app_icon?alt=media&token=799e02c2-3bb6-4751-8572-4f0cdf2a9496';
  // --------------------
  /// BLDRS NAME SQUARE
  static const String bldrsNameSquarePicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbldrs_name?alt=media&token=68bf32bf-2a08-40c8-ab92-748942d47edf';
  // --------------------
  /// BLDRS NAME
  static const String bldrsNamePosterPicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbldrs_name_poster.png?alt=media&token=70e6913b-e062-400d-84d3-08b6685ca037';
  // --------------------
  /// BLDRS NOTIFICATION ICON
  static const String bldrsNotificationSenderID = 'Bldrs.net';
  static const String bldrsNotificationIconURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fbldrs_notification_icon.png?alt=media&token=24fc3340-2798-42c7-a5b6-380f17c6ae5c';
  // --------------------------------------------------------------------------

  /// ICONS

  // --------------------
  /// ANONYMOUS USER
  static const String anonymousUserPicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fanonymous_user_pic.png?alt=media&token=619c4819-582f-45fe-a884-b8fee86965ac';
  // --------------------------------------------------------------------------

  /// BUSINESS CARDS

  // --------------------
  /// RAGEH SIGNATURE 25
  static const String ragehBzCardPicURL25 = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Frageh_bz_card_25_small?alt=media&token=060c043e-966b-4c55-9ed2-bc1e6a7b07de';
  // --------------------
  /// OLD RAGEH EMAIL SIGNATURE
  static const String ragehBzCardPicURLOld = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Frageh_bz_card.png?alt=media&token=6a4d0520-cf4c-48eb-8361-c05da7d4f96e';
  // --------------------
  /// NOUR EMAIL SIGNATURE
  static const String nourBzCardPicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fnour_bz_card.png?alt=media&token=fa98a298-c163-4c02-8bb4-48972b3fddd9';
  // --------------------------------------------------------------------------

  /// APP STORES LABELS

  // --------------------
  /// ON GOOGLE PLAY STORE
  static const String onGooglePlayStoreLabelPicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fon_google_play_store_badge.png?alt=media&token=221fb970-0e24-4b77-b7f1-7c57b3cdde0e';
  // --------------------
  /// ON APP STORE
  static const String onAppleStoreLabelPicURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fon_app_store_badge.png?alt=media&token=4738626b-db32-4694-8b0e-22de48d8ecef';
  // --------------------------------------------------------------------------

  /// PYRAMID

  // --------------------
  /// PYRAMID LOGO 1024
  static const String pyramidLogo1024URL = '';
  // --------------------
  /// PYRAMID LOGO 150
  static const String pyramidLogo150URL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bldrs%2Fpyramid_logo_150.png?alt=media&token=b8241f8b-9ca9-4dc5-8372-a5b67b5b0bd0';
// -----------------------------------------------------------------------------
}

const List<String> badWords = <String>[
  'fuck',
  'bitch',
  'whore',
  'kos',
  'omak',
];

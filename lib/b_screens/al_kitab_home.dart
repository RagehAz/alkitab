import 'package:alkitab/b_screens/old_quran_screen/opld_qiran_screen.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/buttons/general_buttons/wide_button.dart';
import 'package:bldrs/z_components/layouts/bldrs_screen/bldrs_screen.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class AlKitabHome extends StatefulWidget {
  // --------------------------------------------------------------------------
  const AlKitabHome({
    super.key
  });
  // --------------------
  ///
  // --------------------
  @override
  _AlKitabHomeState createState() => _AlKitabHomeState();
// --------------------------------------------------------------------------
}

class _AlKitabHomeState extends State<AlKitabHome> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _triggerLoading(setTo: true);
        /// GO BABY GO
        await _triggerLoading(setTo: false);

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BldrsScreen(
      canSwipeBack: false,
      canGoBack: false,
      appBarType: AppBarType.non,
      loading: _loading,
      child: FloatingList(
        boxAlignment: Alignment.topCenter,
        padding: Stratosphere.stratosphereSandwich,
        boxColor: const Color.fromRGBO(220, 220, 220, 1),
        columnChildren: <Widget>[

          WideButton(
            verse: Verse.plain('Go to old screen'),
            color: Colorz.black125,
            onTap: () async {
              await BldrsNav.goToNewScreen(screen: const QuranScreen());
            },
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

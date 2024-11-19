import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/z_components/buttons/general_buttons/wide_button.dart';
import 'package:bldrs/z_components/layouts/bldrs_screen/bldrs_screen.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class TheHomeScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const TheHomeScreen({
    super.key
  });
  // --------------------
  ///
  // --------------------
  @override
  _TheHomeScreenState createState() => _TheHomeScreenState();
// --------------------------------------------------------------------------
}

class _TheHomeScreenState extends State<TheHomeScreen> {
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
      canSwipeBack: true,
      loading: _loading,
      title: Verse.plain('Al Kitab'),
      appBarRowWidgets: <Widget>[

        AppBarButton(
          icon: Iconz.more,
          onTap: (){
            blog('Do the thing');
          },
        ),

      ],
      child: FloatingList(
        boxAlignment: Alignment.topCenter,
        padding: Stratosphere.stratosphereSandwich,
        columnChildren: <Widget>[

          WideButton(
            verse: Verse.plain('Button'),
            onTap: () async {

              blog('~~~~~~~~~test~~~~~~~~~~ onTap');

            },
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

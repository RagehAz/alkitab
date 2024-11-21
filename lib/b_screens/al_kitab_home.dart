import 'package:alkitab/b_screens/old_quran_screen/old_quran_screen.dart';
import 'package:alkitab/c_protocols/quran_calculator.dart';
import 'package:alkitab/g_components/sora_tile.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/wire/wire.dart';
import 'package:bldrs/f_helpers/drafters/contextual.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/layouts/bldrs_screen/bldrs_screen.dart';
import 'package:bldrs/z_components/layouts/page_fader.dart';
import 'package:bldrs/z_components/lists/super_list_view.dart';
import 'package:flutter/material.dart';
import 'package:quran_flutter/quran_flutter.dart';

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

        _wordsCountsMap = await QuranCalculator.calculateAndStoreSuraWordsCount();

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
  Map<String, dynamic> _wordsCountsMap = {};
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BldrsScreen(
      canGoBack: false,
      appBarRowWidgets: [

        AppBarButton(
          icon: Iconz.planet,
          buttonColor: Colorz.black50,
          onTap: () async {

            await QuranCalculator.calculateAndStoreSuraWordsCount();

          },
        ),

      ],
      loading: _loading,
      child: SingleWire(
        wire: _loading,
        builder: (bool loading) {

          if (loading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else {

            return PageFader(
              restartOnRebuild: false,
              child: Container(
                color: const Color.fromRGBO(220, 220, 220, 1),
                child: SuperListView(
                  width: context.screenWidth,
                  height: context.screenHeight,
                  itemCount: Quran.surahCount,
                  itemBuilder: (int index){


                    return SoraTile(
                      index: index,
                      wordsCountsMap: _wordsCountsMap,
                      onTap: () async {
                        // await BldrsNav.goToNewScreen(screen: const QuranScreen());
                      },
                    );

                  },

                ),
              ),
            );
          }

        }
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

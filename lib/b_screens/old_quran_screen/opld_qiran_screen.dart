import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/d_progress_bar/a_progress_bar.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/layouts/bldrs_screen/bldrs_screen.dart';
import 'package:bldrs/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class QuranScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const QuranScreen({
    super.key
  });
  // --------------------
  ///
  // --------------------
  @override
  _QuranScreenState createState() => _QuranScreenState();
// --------------------------------------------------------------------------
}

class _QuranScreenState extends State<QuranScreen> {

  int _index = 0;

  String _aya =
  '''
بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ

الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ

الرَّحْمَنِ الرَّحِيمِ

مَالِكِ يَوْمِ الدِّينِ

إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ

اهدِنَا الصِّرَاطَ الْمُسْتَقِيمَ

صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلاَ الضَّالِّينَ
  '''
  ;

  int _wordLength = 0;
  List<String> _words = [];
  final ValueNotifier<String?> _highlight = ValueNotifier(null);
  final ValueNotifier<ProgressBarModel?> _progressBarModel = ValueNotifier(null);
  final ValueNotifier<double> _progressBarOpacity = ValueNotifier(1);
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

    _aya = TextMod.replaceAllCharacters(characterToReplace: '\n', replacement: ' ', input: _aya)!;

    _words = _aya.split(' ').toList();
    _words.removeWhere((element) => element == '');

    _wordLength = _words.length;

    setNotifier(
      notifier: _progressBarModel,
      mounted: mounted,
      value: ProgressBarModel.initialModel(
        numberOfStrips: _wordLength,
        colorAllStrips: Colorz.black125,
      ),
    );

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
    _progressBarOpacity.dispose();
    _progressBarModel.dispose();
    _highlight.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------


  // -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // --------------------
    final String _word = _words[_index];
    // --------------------
    return BldrsScreen(
      canSwipeBack: true,
      loading: _loading,
      title: Verse.plain('Quran Screen'),
      appBarRowWidgets: <Widget>[

        AppBarButton(
          icon: Iconz.more,
          onTap: (){
            blog('Do the thing');
          },
        ),

      ],
      appBarType: AppBarType.non,
      child: Stack(
        children: <Widget>[

          BldrsBox(
            width: Scale.screenWidth(context),
            height: Scale.screenHeight(context),
            color: const Color.fromRGBO(231, 229, 225, 1),
            corners: 0,
            bubble: false,
            onTap: (){
              setState(() {
                _index = _index + 1 == _words.length ? 0 : _index+1;
              });

              _highlight.value = _words[_index];
              ProgressBarModel.onSwipe(
                newIndex: _index,
                progressBarModel: _progressBarModel,
                mounted: mounted,
              );

            },
            subChild: BldrsText(
              verse: Verse.plain(_word),
              color: Colorz.black255,
              margin: 30,
              maxLines: 5,
              size: 5,
              scaleFactor: 2,
              textDirection: TextDirection.rtl,

            ),
          ),

          // Positioned(
          //   top: 0,
          //   child: Container(
          //     width: Scale.screenWidth(context),
          //     child: BldrsText(
          //       verse: Verse.plain(_aya),
          //       size: 0,
          //       scaleFactor: 0.5,
          //       maxLines: 1,
          //       margin: 5,
          //       highlight: _highlight,
          //       color: Colorz.black80,
          //       highlightColor: Colorz.black20,
          //     ),
          //   ),
          // ),

          Positioned(
            bottom: Scale.screenHeight(context) * 0.4,
            child: Transform.flip(
              flipX: true,
              child: ProgressBar(
                flyerBoxWidth: Scale.screenWidth(context),
                progressBarModel: _progressBarModel,
                progressBarOpacity: _progressBarOpacity,
                tinyMode: false,
                loading: false,
              ),
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

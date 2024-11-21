import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/bubble/bubble.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/space/aligner.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/d_progress_bar/a_progress_bar.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/layouts/bldrs_screen/bldrs_screen.dart';
import 'package:bldrs/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:quran_flutter/quran_flutter.dart' as q;


class QuranScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const QuranScreen({
    required this.surah,
    super.key
  });
  // --------------------
  final q.Surah surah;
  // --------------------
  @override
  _QuranScreenState createState() => _QuranScreenState();
  // --------------------------------------------------------------------------
}

class _QuranScreenState extends State<QuranScreen> {

  int _index = 0;

//   String _aya =
//   '''
// بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ
//
// الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ
//
// الرَّحْمَنِ الرَّحِيمِ
//
// مَالِكِ يَوْمِ الدِّينِ
//
// إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ
//
// اهدِنَا الصِّرَاطَ الْمُسْتَقِيمَ
//
// صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلاَ الضَّالِّينَ
//   '''
//   ;

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

  List<q.Verse> _ayat = [];
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _ayat = q.Quran.getSurahVersesAsList(widget.surah.number);

    for (final q.Verse _verse in _ayat) {
      final List<String> _ayaWords = _verse.text.split(' ').toList();
      // _words.removeWhere((element) => element == '');
      _words.addAll(_ayaWords);
    }

    _wordLength = _words.length;

    setNotifier(
      notifier: _progressBarModel,
      mounted: mounted,
      value: ProgressBarModel.initialModel(
        numberOfStrips: _wordLength.clamp(0, 50),
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
        alignment: Alignment.center,
        children: <Widget>[

          BldrsBox(
            width: Scale.screenWidth(context),
            height: Scale.screenHeight(context),
            color: const Color.fromRGBO(231, 229, 225, 1),
            corners: 0,
            bubble: false,
            splashColor: Colorz.nothing,
            onTap: () async {

              final bool _isAtLast = _index + 1 == _words.length;

              if (_isAtLast == true){
                await Nav.goBack(context: context);
              }
              else {

                setState(() {
                  _index = _index+1;
                });

                _highlight.value = _words[_index];
                ProgressBarModel.onSwipe(
                  newIndex: _index,
                  progressBarModel: _progressBarModel,
                  mounted: mounted,
                );

              }




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

          // Positioned(
          //   bottom: Scale.screenHeight(context) * 0.4,
          //   child: Transform.flip(
          //     flipX: true,
          //     child: ProgressBar(
          //       flyerBoxWidth: Scale.screenWidth(context),
          //       progressBarModel: _progressBarModel,
          //       progressBarOpacity: _progressBarOpacity,
          //       tinyMode: false,
          //       loading: false,
          //     ),
          //   ),
          // ),

          // Positioned(
          //   bottom: Scale.screenHeight(context) * 0.4,
          //   child: BldrsText(
          //     verse: Verse.plain('${_index + 1} / ${_words.length}'),
          //     color: Colorz.black125,
          //   ),
          // ),

          Positioned(
            bottom: Scale.screenHeight(context) * 0.4,
            child: Builder(
                builder: (context) {

                  final double _width = BubbleScale.bubbleWidth(context: context);
                  const double _height = 5;
                  final double _percent = (_index + 1) / (_words.length);
                  final double _progressWidth = _width * _percent;
                  final BorderRadius _borders = BorderRadius.circular(_height/2);

                  return Stack(
                    alignment: BldrsAligners.superInverseCenterAlignment(context),
                    children: <Widget>[

                      Container(
                        width: _width,
                        height:  _height,
                        decoration: BoxDecoration(
                          color: Colorz.black125,
                          borderRadius: _borders,
                        ),
                      ),

                      Container(
                        width: _progressWidth,
                        height: _height,
                        decoration: BoxDecoration(
                          color: Colorz.white125,
                          borderRadius: _borders,
                        ),
                      ),

                    ],
                  );
                }
              ),
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

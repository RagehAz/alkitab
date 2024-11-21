import 'package:alkitab/b_screens/old_quran_screen/old_quran_screen.dart';
import 'package:alkitab/c_protocols/quran_calculator.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/bubble/bubble.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/zzz_dash_board/modules/gta/grand_theft_net.dart';
import 'package:flutter/material.dart';
import 'package:quran_flutter/quran_flutter.dart' as qu;

class SoraTile extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SoraTile({
    required this.onTap,
    required this.index,
    required this.wordsCountsMap,
    super.key
  });
  // --------------------
  final Function onTap;
  final int index;
  final Map<String, dynamic> wordsCountsMap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final int _suraNumber = index + 1;

    final qu.Surah _sura = qu.Quran.getSurah(_suraNumber);
    // final int _verseCount = _sura.verseCount;

    final String _text = '$_suraNumber. ${_sura.name}';
    final int _count = QuranCalculator.getWordsCountForSura(_suraNumber, wordsCountsMap);


    // --------------------
    return Bubble(
      bubbleColor: Colorz.black50,
      corners: 5,
      onBubbleTap: () async {

        await BldrsNav.goToNewScreen(
            screen: QuranScreen(
              surah: _sura,
            ),
        );

      },
      margin: const EdgeInsets.only(bottom: 5),
      columnChildren: [

        BldrsText(
          verse: Verse.plain(_text),
          weight: VerseWeight.black,
        ),

        // Container(
        //   width: _width,
        //   height: _countHeight,
        //   color: Colorz.white200,
        // ),

        /// PROGRESS CHART
        AssetsWrapper(
            width: BubbleScale.clearWidth(context: context),
            spacing: 1,
            color: Colorz.nothing,
            children: [

              ...List.generate(_count, (int index){

                return Container(
                  width: 4,
                  height: 1.5,
                  color: Colorz.white255,
                  // decoration: const BoxDecoration(
                  //   borderRadius: BorderRadius.all(Radius.circular(1)),
                  //   color: Colorz.white255
                  // ),
                );

              }),

            ],
        ),

      ],
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}

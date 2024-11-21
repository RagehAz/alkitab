import 'package:alkitab/d_backend/d_ldb/ldb_doc.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/ldb/ldb.dart';
import 'package:quran_flutter/quran_flutter.dart';

class QuranCalculator {
  // -----------------------------------------------------------------------------

  const QuranCalculator();

  // -----------------------------------------------------------------------------

  /// TITLE

  // --------------------
  ///
  static Future<Map<String, dynamic>> calculateAndStoreSuraWordsCount() async {

    const String docName = 'words_counts';

    Map<String, dynamic>? _map = await LDBOps.readMap(
        docName: docName,
        id: 'id',
        primaryKey: 'id',
    );

    if (_map == null){

      _map = {};

      final List<Surah> _sowar = Quran.getSurahAsList();

      await Lister.loop(
        models: _sowar,
        onLoop: (int index, Surah? surah) async {

          if (surah != null){

            final String _nameEN = surah.name;

            final List<Verse> _verses = Quran.getSurahVersesAsList(surah.number, language: QuranLanguage.english);

            int _count = 0;
            for (final Verse _verse in _verses) {
              final List<String> _words = _verse.text.split(' ');
              _count = _count + _words.length;
            }

            _map = Mapper.insertPairInMap(
              map: _map,
              key: _nameEN,
              value: _count,
              overrideExisting: true,
            );

          }


        },
      );

      await LDBOps.insertMap(
          docName: docName,
          primaryKey: 'id',
          input: {
            'id': 'id',
            'data': _map,
      },
      );

    }

    else {
      _map = _map['data'];
    }

    return _map ?? {};
  }
  // --------------------
  ///
  static int getWordsCountForSura(int suraNumber, Map<String, dynamic> wordsCountsMap) {
    final Surah _sura = Quran.getSurah(suraNumber);
    final String _nameEN = _sura.name;
    final int _count = wordsCountsMap[_nameEN] ?? 0;
    return _count;
  }
  // -----------------------------------------------------------------------------
}

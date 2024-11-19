import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/ldb/ldb.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
/// => TAMAM
class CleanSlateProtocol {
  // -----------------------------------------------------------------------------

  const CleanSlateProtocol();

  // -----------------------------------------------------------------------------
  static const String _ldbDocName = 'theCleanSlate';
  static const String _primaryKey = 'id';
  static const String _idValue = 'cleanSlate';
  // -----------------------------------------------------------------------------

  /// CLEAN SLATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> start() async {
    bool _wiped = false;

    final bool _done = await _checkIsDone();

    if (_done == false){

      final bool _done = await _cleanEverything();

      if (_done == true){
        _wiped = await _markSlateAsClean();
      }

    }

    blog('CleanSlateProtocol: _wiped($_wiped)');

    return _wiped;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _checkIsDone() async {

    final Map<String, dynamic>? _map = await LDBOps.readMap(
        docName: _ldbDocName,
        primaryKey: _primaryKey,
        id: _idValue,
    );

    return Mapper.boolIsTrue(_map?['done']);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _markSlateAsClean() async {

    final bool _wiped = await LDBOps.insertMap(
      docName: _ldbDocName,
      primaryKey: _primaryKey,
      input: {
        'id': _idValue,
        'done': true,
      },
    );

    return _wiped;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _cleanEverything() async {
    bool _done = false;

    await tryAndCatch(
        invoker: '_cleanEverything',
        functions: () async {

          /// IMAGE CACHES
          await ImageCacheOps.wipeCaches();

          await LDBDoc.onHardRebootSystem();

          /// DONT DO THIS : BREAKS LDB SOMEHOW
          // for (final DirectoryType dir in Director.allDirectoryTypes()){
          //   await Director.deleteAllDirectoryFiles(
          //     directoryType: dir,
          //   );
          // }

          _done = true;

        },
    );

    return _done;
  }
  // -----------------------------------------------------------------------------
}

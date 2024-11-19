part of alkitab_engine;

class TheLastWiper {
// -----------------------------------------------------------------------------

  const TheLastWiper();

  // -----------------------------------------------------------------------------
  static const String _docName = LDBDoc.theLastWipe;
  static const String _mapID = 'theLastWipeMapID';
  // -----------------------------------------------------------------------------

  /// MONITOR

  // --------------------
  /// DEPRECATED
  /*
  static Future<void> monitorRefreshLDBThing() async {

    if (kDebugMode == true){

      final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
        ids: ['theLastWipeMap'],
        docName: 'theLastWipeMap',
        primaryKey: 'id',
      );

      // ignore: unused_local_variable
      bool _shouldRefresh = false;
      double? _diff;
      DateTime? _lastWipe;

      if (Lister.checkCanLoop(_maps) == true){

        _lastWipe = Timers.decipherTime(
          time: _maps.first['time'],
          fromJSON: true,
        );

        _diff = Timers.calculateTimeDifferenceInMinutes(
          from: _lastWipe,
          to: DateTime.now(),
        ).toDouble();

        _diff = Numeric.modulus(_diff);

        /// ONLY WHEN NOT EXCEEDED THE TIME SHOULD NOT REFRESH
        if (_diff != null && _diff < Standards.ldbWipeIntervalInMinutes){
          _shouldRefresh = false;
        }
        else {
          _shouldRefresh = true;
        }

      }

      // blog('checkShouldRefreshLDB : $_shouldRefresh');

//       blog('''
// _diff Minutes
//
// Last Wipe : $_lastWipe
//
// ($_diff) < (${Standards.ldbWipeIntervalInMinutes}) >  = (${Numeric.isLesserThan(number: Standards.ldbWipeIntervalInMinutes, isLesserThan: _diff)}))
//             ''');

    }

  }
   */
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkShouldRefreshLDB({
    int refreshDurationInMinutes = 60,
  }) async {
    bool _should = false;

    /// NOTE : if did not find last wipe dateTime => will wipe
    /// if found and its more than {24 hours} => will wipe
    /// if found and its less than {24 hours} => will not wipe

    final DateTime? _lastWipe = await _readLastWipeTime();

    final bool _timeLimitReached = _checkTimeLimitReached(
        time: _lastWipe,
        limitInMinutes: refreshDurationInMinutes
    );

    if (_lastWipe == null || _timeLimitReached == true){
      _should = true;
      await LDBOps.insertMap(
        docName: _docName,
        primaryKey: 'id',
        input: _createNowMap(),
      );
    }

    if (_should){
      blog('_lastWipe($_lastWipe) : _timeLimitReached($_timeLimitReached) : refreshDurationInMinutes($refreshDurationInMinutes) : _createNowMap(${_createNowMap()})');
    }

    return _should;
  }
  // -----------------------------------------------------------------------------

  /// MAPPING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> _createNowMap(){
    return {
      'id': _mapID,
      'time': Timers.cipherTime(time: DateTime.now(), toJSON: true),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DateTime?> _readLastWipeTime() async {

    final Map<String, dynamic>? _map = await LDBOps.readMap(
      id: _mapID,
      docName: _docName,
      primaryKey: 'id',
    );

    final DateTime? _lastWipe = Timers.decipherTime(
      time: _map?['time'],
      fromJSON: true,
    );

    return _lastWipe;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool _checkTimeLimitReached({
    required DateTime? time,
    required int limitInMinutes,
  }){
    bool _limitReached = false;

    if (time != null){

      double? _diff = Timers.calculateTimeDifferenceInMinutes(
        from: time,
        to: DateTime.now(),
      ).toDouble();

      _diff = Numeric.modulus(_diff);

      /// ONLY WHEN NOT EXCEEDED THE TIME SHOULD NOT REFRESH
      if (_diff != null && _diff >= limitInMinutes){
        _limitReached = true;
      }

    }

    return _limitReached;
  }
  // -----------------------------------------------------------------------------
}

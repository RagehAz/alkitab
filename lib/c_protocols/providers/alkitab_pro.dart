import 'package:bldrs/c_protocols/main_providers/home_pro.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AlKitabProviders extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const AlKitabProviders({
    required this.child,
    super.key
  });
  // --------------------
  final Widget child;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<HomePro>(create: (BuildContext ctx) => HomePro()),
        ChangeNotifierProvider<UiPro>(create: (BuildContext ctx) => UiPro()),
        // ChangeNotifierProvider<UserPro>(create: (BuildContext ctx) => UserPro()),
        // ChangeNotifierProvider<GeneralPro>(create: (BuildContext ctx) => GeneralPro()),
        // ChangeNotifierProvider<NotesPro>(create: (BuildContext ctx) => NotesPro()),
        // ChangeNotifierProvider<FcPro>(create: (BuildContext ctx) => FcPro()),
      ],
      child: child,
    );

  }
// -----------------------------------------------------------------------------
}

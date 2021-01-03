
import 'package:flutter/material.dart';
import 'package:flutter_app_new/counter_test/bloc_counter.dart';
import 'package:flutter_app_new/list_image/album/album_bloc.dart';
import 'package:flutter_app_new/list_image/album/album_event.dart';
import 'package:flutter_app_new/model/album.dart';
import 'package:flutter_app_new/screen/album.dart';
import 'package:flutter_app_new/screen/photo_detail.dart';
import 'package:flutter_app_new/widget/options_button_span.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

void main() {
  runApp(
    BlocProvider<AlbumBloc>(
      create: (_context) => AlbumBloc().init(),
      child: App(),
    ),
  );
}

/// A [StatelessWidget] which uses:
/// * [bloc](https://pub.dev/packages/bloc)
/// * [flutter_bloc](https://pub.dev/packages/flutter_bloc)
/// to manage the state of a counter.
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AlbumBloc bloc = AlbumBloc();
    return MaterialApp(
      home: BlocProvider(
        create: (_) => bloc,
        child: SafeArea(
          child: AlbumHomePage(bloc),
        ),
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,

      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
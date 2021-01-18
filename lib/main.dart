
import 'package:flutter/material.dart';
import 'package:flutter_app_new/bloc/home/photo_liked/photo_favourite_bloc.dart';
import 'package:flutter_app_new/bloc/home/section/animal.dart';
import 'package:flutter_app_new/bloc/home/section/fashion.dart';
import 'package:flutter_app_new/bloc/home/section/nature.dart';
import 'package:flutter_app_new/bloc/home/section/text.dart';
import 'package:flutter_app_new/screen/album.dart';
import 'package:flutter_app_new/screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/album/album_bloc.dart';
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
    // AlbumBloc bloc = ;
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AlbumBloc(),
          ),
          BlocProvider(
            create: (context) => AnimalBloc(),
          ),
          BlocProvider(
            create: (context) => NatureBloc(),
          ),
          BlocProvider(
            create: (context) => TextBloc(),
          ),
          BlocProvider(
            create: (context) => FashionBloc(),
          ),
          BlocProvider(
            create: (context) => PhotoFavouriteBloc(),
          )
        ],
        child: SafeArea(
          child: HomeScreen(),
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
      navigatorObservers: [RouteObserver<PageRoute>()],
    );
  }
}
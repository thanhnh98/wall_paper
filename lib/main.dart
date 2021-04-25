import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_new/bloc/home/photo_liked/photo_favourite_bloc.dart';
import 'package:flutter_app_new/bloc/home/section/animal.dart';
import 'package:flutter_app_new/bloc/home/section/fashion.dart';
import 'package:flutter_app_new/bloc/home/section/nature.dart';
import 'package:flutter_app_new/bloc/home/section/text.dart';
import 'package:flutter_app_new/bloc/observe/favourite_photo_observe.dart';
import 'package:flutter_app_new/bloc/photo/photo_detail_bloc.dart';
import 'package:flutter_app_new/helper/deeplink.dart';
import 'package:flutter_app_new/screen/album/album.dart';
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


class App extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> with RouteAware{
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
            create: (context) => FavouritePhotoObserve.of(),
          ),
          BlocProvider(
              create: (context) => PhotoDetailBloc(),
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
      navigatorObservers: [
        routeObserver
      ],
    );
  }

}
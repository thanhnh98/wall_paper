// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Select one`
  String get select_one {
    return Intl.message(
      'Select one',
      name: 'select_one',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Options`
  String get options {
    return Intl.message(
      'Options',
      name: 'options',
      desc: '',
      args: [],
    );
  }

  /// `Photo by `
  String get photo_by {
    return Intl.message(
      'Photo by ',
      name: 'photo_by',
      desc: '',
      args: [],
    );
  }

  /// `Contact `
  String get contact {
    return Intl.message(
      'Contact ',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Lock Screen`
  String get lock_screen {
    return Intl.message(
      'Lock Screen',
      name: 'lock_screen',
      desc: '',
      args: [],
    );
  }

  /// `Home Screen`
  String get home_screen {
    return Intl.message(
      'Home Screen',
      name: 'home_screen',
      desc: '',
      args: [],
    );
  }

  /// `Both Screens`
  String get both_screens {
    return Intl.message(
      'Both Screens',
      name: 'both_screens',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
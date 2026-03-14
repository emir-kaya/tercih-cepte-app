import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('tr')) {
    _loadLocale();
  }

  static const _key = 'locale';

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key) ?? 'tr';
    emit(Locale(code));
  }

  Future<void> setLocale(Locale locale) async {
    emit(locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.languageCode);
  }

  Future<void> toggleLocale() async {
    final next = state.languageCode == 'tr'
        ? const Locale('en')
        : const Locale('tr');
    await setLocale(next);
  }

  bool get isTurkish => state.languageCode == 'tr';
}

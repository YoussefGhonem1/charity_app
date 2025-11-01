import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void setThemeMode(ThemeMode mode) => emit(mode);

  void toggleDark(bool enabled) => emit(enabled ? ThemeMode.dark : ThemeMode.light);
}



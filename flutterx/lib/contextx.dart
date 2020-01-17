library contextx;

import 'package:flutter/material.dart';

extension BuildContextX<T extends BuildContext> on T {
  ThemeData theme({bool shadowThemeOnly}) => Theme.of(this, shadowThemeOnly: shadowThemeOnly);

  NavigatorState navigator({
    bool rootNavigator,
    bool nullOk,
  }) => Navigator.of(this,
    rootNavigator: rootNavigator,
    nullOk: nullOk,
  );

  FocusScopeNode focusScope() => FocusScope.of(this);

  ModalRoute<T> modalRoute<T>() => ModalRoute.of<T>(this);
}
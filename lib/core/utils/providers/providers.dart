import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Providers {
  final List<ChangeNotifier> _changeNotifiers;
  final Widget child;

  Providers(this._changeNotifiers, this.child);

  MultiProvider initAndReturnMultiProvider() {
    return MultiProvider(
      providers: List.generate(_changeNotifiers.length, (index) {
        return ChangeNotifierProvider(
          create: (_) => _changeNotifiers[index],
        );
      }),
      child: child,
    );
  }
}

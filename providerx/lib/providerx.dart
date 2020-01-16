library providerx;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ProviderBuildContextX<T extends BuildContext> on T {
  R provider<R extends ChangeNotifier>({bool listen}) => Provider.of<R>(this, listen: listen);
}

library provider_dtx;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ProviderBuildContextX<T extends BuildContext> on T {
  R provider<R extends ChangeNotifier>({bool listen = true}) => Provider.of<R>(this, listen: listen);
}

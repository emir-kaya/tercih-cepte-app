import 'package:flutter/widgets.dart';

import '../../l10n/app_localizations.dart';

/// Shorthand for accessing localized strings: `context.l10n.homeGreeting('Emir')`
extension L10nContext on BuildContext {
  L10n get l10n => L10n.of(this);
}

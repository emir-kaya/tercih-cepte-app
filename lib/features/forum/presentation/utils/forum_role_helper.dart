import 'package:flutter/material.dart';

import '../../../../core/locale/l10n_extension.dart';

String localizeRole(BuildContext context, String role) {
  final t = context.l10n;
  return switch (role) {
    'highSchool' => t.roleCandidate,
    'university' => t.roleStudent,
    'graduate' => t.roleGraduate,
    'user' => t.roleUser,
    _ => role, // Fallback for legacy data
  };
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomServerError extends StatelessWidget {
  final String? message;
  const CustomServerError({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Center(
      child: Text(message ?? lang.error),
    );
  }
}

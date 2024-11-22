import 'package:flutter/material.dart';

class PrettyJson extends StatelessWidget {
  final String json;
  const PrettyJson({
    super.key,
    required this.json,
  });

  @override
  Widget build(BuildContext context) {
    final formatL = json
        .replaceAll('{', '{\n')
        .replaceAll('}', '\n}')
        .replaceAll(',', ',\n')
        .replaceAll(':', ' : ')
        .split('\n');
    List<String> format = [];
    int tabs = 2;
    for (int i = 0; i < formatL.length; i++) {
      if (formatL[i].contains('{')) {
        format.add('    ' * tabs + formatL[i]);
        tabs++;
      } else if (formatL[i].contains('}')) {
        tabs--;
        format.add('    ' * tabs + formatL[i]);
      } else {
        format.add('    ' * tabs + formatL[i]);
      }
    }

    return Text(format.join('\n'));
  }
}

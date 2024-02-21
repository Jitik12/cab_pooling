import 'package:flutter/material.dart';
import 'package:swift_street/utilities/dialogs/generic_dialog.dart';

Future<void> showOkDialog({
  required BuildContext context,
  required String title,
  required String content,
}) async {
  await showGenericDialog<bool>(
    context: context,
    title: title,
    content: content,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}

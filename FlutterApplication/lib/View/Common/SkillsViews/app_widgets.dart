import 'package:flutter/material.dart';
class AppWidgets{
  static SnackBar connectionSnackBar = SnackBar(
    content: Text("L'action n'a pas abouti: vérifiez votre connection et réesssayez." ),
    action: SnackBarAction(
      label: 'Compris!',
      onPressed: () {},
    ),
  );

}

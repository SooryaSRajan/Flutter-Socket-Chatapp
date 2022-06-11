import 'package:flutter/material.dart';

displayDialog(
    {required BuildContext context,
    required String positiveText,
    required String negativeText,
    required Function positiveFunction,
    required String title,
    required String subTitle,
    bool? dismissDialog,
    bool? willPop}) {
  return showDialog(
    context: context,
    barrierDismissible: dismissDialog ?? true,
    builder: (context) => WillPopScope(
      onWillPop: () async => willPop ?? true,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          subTitle,
        ),
        actions: <Widget>[
          negativeText != null
              ? TextButton(
                  key: const Key('negative_b'),
                  child: Text(
                    negativeText,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              : Container(),
          ElevatedButton(
            key: const Key('positive_b'),
            child: Text(
              positiveText,
            ),
            onPressed: () async {
              positiveFunction();
            },
          ),
        ],
      ),
    ),
  );
}

displayQuitDialog(context, title, subTitle) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(
        subTitle,
      ),
      actions: <Widget>[
        TextButton(
          key: const Key('no_b'),
          child: const Text(
            "No",
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        ElevatedButton(
          key: const Key('yes_b'),
          child: const Text(
            "Yes",
          ),
          onPressed: () async {
            Navigator.pop(context, true);
          },
        ),
      ],
    ),
  );
}

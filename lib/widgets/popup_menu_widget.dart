import 'package:flutter/material.dart';
import 'package:imoto/services/auth_service.dart';
import 'package:share_plus/share_plus.dart';

import '../constants.dart';

PopupMenuButton popupMenuButton({required BuildContext context}) {
  return PopupMenuButton<String>(
      onSelected: (selected) async {
        switch (selected) {
          case 'logout':
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('Imoto'),
                      content: Text('Are you sure you want to log out'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No')),
                        TextButton(
                            onPressed: () {
                              AuthService().signOut()!.then((value) {
                                Navigator.pushNamed(context, '/auth');
                              });
                            },
                            child: Text('Yes'))
                      ],
                    ));
            return;

          case 'share':
            await Share.share('Imoto : ${Constants().appLink}');
            return;
        }
      },
      itemBuilder: (context) => [
            PopupMenuItem<String>(
                value: 'share',
                child: ListTile(
                  contentPadding: EdgeInsets.all(0.0),
                  leading: Icon(Icons.share_rounded),
                  title: Text('Share App'),
                )),
            PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  contentPadding: EdgeInsets.all(0.0),
                  leading: Icon(Icons.logout_rounded),
                  title: Text('Log Out'),
                )),
          ]);
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Drawer drawer({required BuildContext context}) {
  return Drawer(
    child: SingleChildScrollView(
      child: Column(
        children: [
          DrawerHeader(
              child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/logo.png'), fit: BoxFit.contain)),
          )),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                content: Text('Coming Soon'),
              ));
            },
            leading: FaIcon(FontAwesomeIcons.carAlt),
            title: Text('Car Brands', style: TextStyle(fontSize: 18)),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/parts');
            },
            leading: FaIcon(FontAwesomeIcons.toolbox),
            title: Text(
              'Parts',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            onTap: () {
              // Navigator.pushNamed(context, '/car_finance');
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                content: Text('Coming Soon'),
              ));
            },
            leading: FaIcon(FontAwesomeIcons.fileInvoice),
            title: Text('Car Finance', style: TextStyle(fontSize: 18)),
          ),
          ListTile(
            onTap: () {
              // Navigator.pushNamed(context, '/car_insurance');
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                content: Text('Coming Soon'),
              ));
            },
            leading: FaIcon(FontAwesomeIcons.paperclip),
            title: Text('Car Finance', style: TextStyle(fontSize: 18)),
          ),
          ListTile(
            onTap: () {
              // Navigator.pushNamed(context, '/car_check');
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                content: Text('Coming Soon'),
              ));
            },
            leading: FaIcon(FontAwesomeIcons.checkDouble),
            title: Text('Car Check', style: TextStyle(fontSize: 18)),
          ),
          ListTile(
            onTap: () {
              // Navigator.pushNamed(context, '/financial_calculator');
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                content: Text('Coming Soon'),
              ));
            },
            leading: FaIcon(FontAwesomeIcons.calculator),
            title: Text(
              'Financial Calculator',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    ),
  );
}

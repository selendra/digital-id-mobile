import 'package:flutter/material.dart';
import 'package:digital_id/all_export.dart';
import 'package:digital_id/models/dashboard_m.dart';


class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return AccountPageBody();
  }
}

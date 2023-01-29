import 'package:flutter/material.dart';
import 'package:get_camped/database/allvariables.dart';
import 'userpages/userrsvscreen.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    searchedList = null;
    return Scaffold(
      body: UsersRsvScreen(),
    );
  }
}

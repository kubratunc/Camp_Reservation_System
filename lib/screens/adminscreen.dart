import 'package:flutter/material.dart';
import '../database/theme.dart';
import '../database/allmethods.dart';
import '../database/allclasses.dart';
import '../database/allvariables.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    searchedList = null;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Admin Paneli',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSizeL,
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AdminInfoBox(
                user: currentUser,
              ),
              const ManageUsersButton(),
              const ManageCampsButton(),
              // const ManageRsvsButton(),
            ],
          ),
        ),
      ),
    );
  }
}

// Admin Bilgileri
class AdminInfoBox extends StatelessWidget {
  final User user;
  const AdminInfoBox({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 20, 5, 20),
      child: (user.name != null && user.surname != null)
          ? Column(
              children: [
                Text(
                  'Hoşgeldin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: fontSizeM,
                  ),
                ),
                Text(
                  user.name! + ' ' + user.surname!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSizeL,
                  ),
                ),
              ],
            )
          : Text(
              '(İsim Mevcut Değil)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: fontSizeL,
              ),
            ),
    );
  }
}

// Butonlar
class ManageUsersButton extends StatelessWidget {
  const ManageUsersButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await clearAllControllers();
        searchedList = null;
        Navigator.pushNamed(context, '/mngusersscreen');
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        margin: const EdgeInsets.all(5),
        child: Text(
          'Kullanıcıları Yönet',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSizeM,
          ),
        ),
        decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
    );
  }
}

class ManageCampsButton extends StatelessWidget {
  const ManageCampsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await clearAllControllers();
        searchedList = null;
        Navigator.pushNamed(context, '/mngcampsscreen');
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        margin: const EdgeInsets.all(5),
        child: Text(
          'Kamp Alanlarını Yönet',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSizeM,
          ),
        ),
        decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
    );
  }
}

class ManageRsvsButton extends StatelessWidget {
  const ManageRsvsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await clearAllControllers();
        searchedList = null;
        // ROTAAA <==================
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        margin: const EdgeInsets.all(5),
        child: Text(
          'Rezervasyonları Yönet',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSizeM,
          ),
        ),
        decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
    );
  }
}

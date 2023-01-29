import 'package:flutter/material.dart';
import '../database/allvariables.dart';
import '../database/allmethods.dart';
import '../database/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'GetCamped!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 60,
                ),
              ),
              Text(
                'Hoşgeldiniz',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: fontSizeL,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: ssnController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "TC Kimlik No",
                  ),
                ),
              ),
              LoginButton(notifyParent: refresh),
            ],
          ),
        ),
      ),
    );
  }
}

class UserNotExistBox extends StatelessWidget {
  const UserNotExistBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                'Böyle bir kullanıcı bulunmamaktadır.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: fontSizeM,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 200,
                margin: const EdgeInsets.all(5),
                child: Text(
                  'Tamam',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSizeM,
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Function() notifyParent;
  LoginButton({Key? key, required this.notifyParent}) : super(key: key);
  var control;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () async {
          control = await loginCheck(ssnController.text);
          await clearAllControllers();
          if (control == 1) {
            Navigator.pushNamed(context, '/adminscreen');
          } else if (control == 0) {
            Navigator.pushNamed(context, '/userscreen');
          } else {
            notifyParent();
            await connection.close();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: const UserNotExistBox(),
                  contentPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            );
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: 200,
          child: Text(
            'Giriş Yap',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSizeM,
            ),
          ),
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
      ),
      margin: const EdgeInsets.all(5),
    );
  }
}

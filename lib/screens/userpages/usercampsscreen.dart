import 'package:flutter/material.dart';
import 'package:get_camped/database/allmethods.dart';
import 'package:get_camped/database/theme.dart';
import '../../database/allclasses.dart';
import '../../database/allvariables.dart';

class UsersCampsScreen extends StatefulWidget {
  const UsersCampsScreen({Key? key}) : super(key: key);

  @override
  State<UsersCampsScreen> createState() => _UsersCampsScreenState();
}

class _UsersCampsScreenState extends State<UsersCampsScreen> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Kamp Alanlarını Görüntüle',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSizeL,
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            SearchCampBox(notifyParent: refresh),
            (searchedList != null)
                ? Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        for (var x in searchedList)
                          UserBox(
                            ssn: x[0] ?? '--',
                            name: x[1] ?? '--',
                            surname: x[2] ?? '--',
                            phone: x[3] ?? '--',
                            hesCode: x[4] ?? '--',
                            notifyParent: refresh,
                          ),
                      ],
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.fromLTRB(5, 30, 5, 30),
                    child: Text(
                      'Gösterilecek bir veri yok.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: fontSizeM,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// TOP BUTTONS AND SEARCH
class SearchCampBox extends StatefulWidget {
  final Function() notifyParent;
  const SearchCampBox({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<SearchCampBox> createState() => _SearchCampBoxState();
}

class _SearchCampBoxState extends State<SearchCampBox> {
  String tentExist = 'Yok';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 8),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Kamp Adı",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 8),
                child: TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Şehir",
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 25, 5, 0),
                child: DropdownButton<String>(
                  value: tentExist,
                  elevation: 16,
                  underline: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      tentExist = newValue!;
                    });
                  },
                  items: <String>['Var', 'Yok']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 8),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: minPriceController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "₺ En Az",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 8),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: maxPriceController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "₺ En Çok",
                  ),
                ),
              ),
            ),
          ],
          // Çadır var mı yok mu?
          // Fiyat Aralığı
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 8),
                child: TextFormField(
                  controller: idController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Kamp ID",
                  ),
                ),
              ),
            ),
            Container(
              child: FittedBox(
                child: InkWell(
                  onTap: () async {
                    bool tentValue = (tentExist == 'Var') ? true : false;
                    await searchForCamp(tentValue);
                    await clearAllControllers();
                    widget.notifyParent();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 70,
                    height: 50,
                    child: Text(
                      'Ara',
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
              ),
              margin: const EdgeInsets.all(5),
            ),
          ],
        )
      ],
    );
  }
}

// REPEATED USER BOX
class UserBox extends StatelessWidget {
  final String ssn;
  final String name;
  final String surname;
  final String phone;
  final String hesCode;
  final Function() notifyParent;
  const UserBox({
    Key? key,
    required this.ssn,
    required this.name,
    required this.surname,
    required this.phone,
    required this.hesCode,
    required this.notifyParent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(5, 5, 5, 15),
            child: Column(
              children: [
                Text(
                  'TC: ' + ssn,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: fontSizeS,
                  ),
                ),
                Text(
                  name + ' ' + surname,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSizeL,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Telefon: ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: fontSizeM,
                  ),
                ),
                Text(
                  phone,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSizeM,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'HES Kodu: ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: fontSizeM,
                  ),
                ),
                Text(
                  hesCode,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSizeM,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: const BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}

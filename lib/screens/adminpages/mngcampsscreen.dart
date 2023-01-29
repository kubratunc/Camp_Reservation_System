import 'package:flutter/material.dart';
import '../../database/allmethods.dart';
import '../../database/allvariables.dart';
import '../../database/theme.dart';

class MngCampsScreen extends StatefulWidget {
  const MngCampsScreen({Key? key}) : super(key: key);

  @override
  State<MngCampsScreen> createState() => _MngCampsScreenState();
}

class _MngCampsScreenState extends State<MngCampsScreen> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Kamp Alanlarını Yönet',
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
            Row(
              children: [
                Expanded(
                  child: ListAllButton(notifyParent: refresh),
                ),
                Expanded(
                  child: AddCampButton(notifyParent: refresh),
                )
              ],
            ),
            (searchedList != null)
                ? Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        for (var x in searchedList)
                          CampBox(
                            id: x[0] ?? '--',
                            name: x[1] ?? '--',
                            city: x[2] ?? '--',
                            dailyPrice: x[3] ?? '--',
                            tent: x[4] ?? '--',
                            capacity: x[5] ?? '--',
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
class SearchCampBox extends StatelessWidget {
  final Function() notifyParent;
  SearchCampBox({Key? key, required this.notifyParent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
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
                await getSingleCamp(int.parse(idController.text));
                await clearAllControllers();
                notifyParent();
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
    );
  }
}

class ListAllButton extends StatelessWidget {
  final Function() notifyParent;
  const ListAllButton({Key? key, required this.notifyParent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () async {
          await getAllCamps();
          notifyParent();
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          alignment: Alignment.center,
          height: 50,
          child: Text(
            'Tüm Kamplar',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSizeM,
            ),
          ),
        ),
      ),
      margin: const EdgeInsets.all(5),
    );
  }
}

class AddCampButton extends StatelessWidget {
  final Function() notifyParent;
  const AddCampButton({Key? key, required this.notifyParent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: AddCampBox(notifyParent: notifyParent),
                contentPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          );
        },
        child: Container(
          alignment: Alignment.center,
          height: 50,
          child: Text(
            'Kamp Ekle',
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
      margin: const EdgeInsets.all(5),
    );
  }
}

// REPEATED Camp BOX
class CampBox extends StatelessWidget {
  final int id;
  final String name;
  final String city;
  final int capacity;
  final int dailyPrice;
  final bool tent;
  final Function() notifyParent;
  const CampBox({
    Key? key,
    required this.id,
    required this.name,
    required this.city,
    required this.capacity,
    required this.dailyPrice,
    required this.tent,
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
                  'ID: ' + id.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: fontSizeS,
                  ),
                ),
                Text(
                  name + ' - ' + city,
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
                  'Kapasite: ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: fontSizeM,
                  ),
                ),
                Text(
                  capacity.toString(),
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
                  'Günlük Ücret: ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: fontSizeM,
                  ),
                ),
                Text(
                  dailyPrice.toString(),
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
                  'Çadır: ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: fontSizeM,
                  ),
                ),
                Text(
                  (tent) ? 'Var' : 'Yok',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSizeM,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: EditCampBox(
                              id: id,
                              name: name,
                              tent: tent,
                              dailyPrice: dailyPrice,
                              notifyParent: notifyParent,
                            ),
                            contentPadding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        'Düzenle',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSizeM,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: DeleteCampBox(
                                id: id, notifyParent: notifyParent),
                            contentPadding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        'Sil',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSizeM,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
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

// FUNCTION BOXES
class AddCampBox extends StatefulWidget {
  final Function() notifyParent;
  const AddCampBox({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<AddCampBox> createState() => _AddCampBoxState();
}

class _AddCampBoxState extends State<AddCampBox> {
  String tentExist = 'Yok';
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 2 / 3,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  'Yeni Kamp Bilgileri',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: fontSizeM,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                child: Container(
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "İsim",
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                child: Container(
                  child: TextFormField(
                    controller: cityController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Şehir",
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                child: Container(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: dailyPriceController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Günlük Ücret",
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    'Çadır var mı? ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSizeS,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
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
                ],
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                child: Container(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: capacityController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Kapasite",
                    ),
                  ),
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    bool tentValue = (tentExist == 'Var') ? true : false;
                    int control = await addNewCamp(tentValue);
                    await clearAllControllers();
                    searchedList = null;
                    widget.notifyParent();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: CampAddedBox(
                            control: control,
                          ),
                          contentPadding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 150,
                    child: Text(
                      'Kaydet',
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
                margin: const EdgeInsets.all(5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditCampBox extends StatefulWidget {
  final int id;
  final String name;
  final bool tent;
  final int dailyPrice;
  final Function() notifyParent;
  const EditCampBox({
    Key? key,
    required this.id,
    required this.name,
    required this.tent,
    required this.dailyPrice,
    required this.notifyParent,
  }) : super(key: key);

  @override
  State<EditCampBox> createState() => _EditCampBoxState();
}

class _EditCampBoxState extends State<EditCampBox> {
  String tentExist = 'Yok';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 2 / 3,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  'Yeni Kamp Bilgileri',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: fontSizeM,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Şuanki İsim: ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      widget.name,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Yeni İsim",
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Şuanki Çadır Durumu: ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      (widget.tent) ? 'Var' : 'Yok',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Çadır var mı? ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSizeS,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
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
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Şuanki Günlük Ücret: ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      widget.dailyPrice.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: dailyPriceController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Yeni Günlük Ücret",
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  bool tentValue = (tentExist == 'Var') ? true : false;
                  updateCamp(widget.id, tentValue);
                  Navigator.pop(context);
                  clearAllControllers();
                  widget.notifyParent();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: CampUpdatedBox(),
                        contentPadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 200,
                  margin: const EdgeInsets.all(5),
                  child: Text(
                    'Kaydet',
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
      ),
    );
  }
}

class DeleteCampBox extends StatelessWidget {
  final int id;
  final Function() notifyParent;
  const DeleteCampBox({Key? key, required this.id, required this.notifyParent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 2 / 3,
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
                'Bu kullanıcıyı silmek istediğinize emin misiniz?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: fontSizeM,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        'Hayır',
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
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      await deleteCamp(id);
                      Navigator.pop(context);
                      searchedList = null;
                      notifyParent();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: CampDeletedBox(),
                            contentPadding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        'Evet',
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// INFORMATION BOXES
class CampAddedBox extends StatelessWidget {
  final int control;
  const CampAddedBox({Key? key, required this.control}) : super(key: key);
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
                (control == 1)
                    ? 'Kamp başarıyla eklendi.'
                    : (control == 0)
                        ? 'Bilgiler boş bırakılamaz.'
                        : 'Bu kamp zaten var.',
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

class CampUpdatedBox extends StatelessWidget {
  const CampUpdatedBox({Key? key}) : super(key: key);
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
                'Kullanıcı bilgileri güncellendi.',
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

class CampDeletedBox extends StatelessWidget {
  const CampDeletedBox({Key? key}) : super(key: key);
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
                'Kamp alanı başarıyla silindi.',
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

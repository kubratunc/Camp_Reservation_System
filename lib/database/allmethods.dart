import 'package:postgres/postgres.dart';
import 'package:intl/intl.dart';
import 'allclasses.dart';
import 'allvariables.dart';

// === ADMIN FUNCTIONS ===
// User Management
Future getAllUsers() async {
  searchedList = null;
  searchedList = await connection.query('''
    SELECT * FROM users
    ''');
}

Future getSingleUser(String ssn) async {
  var count;
  searchedList = null;

  count = await connection.query(
    '''
      SELECT count(*)
      FROM users
      WHERE ssn=@ssn;
    ''',
    substitutionValues: {
      'ssn': ssn,
    },
  );

  if (count[0][0] == 0) {
    searchedList = null;
  } else {
    searchedList = await connection.query(
      '''
      SELECT *
      FROM users
      WHERE ssn=@ssn;
    ''',
      substitutionValues: {
        'ssn': ssn,
      },
    );
  }
}

Future<int> addNewUser() async {
  if (ssnController.text.isEmpty ||
      nameController.text.isEmpty ||
      surnameController.text.isEmpty ||
      phoneController.text.isEmpty ||
      hesCodeController.text.isEmpty) {
    return 0;
  } else {
    try {
      await connection.query(
        '''
          INSERT INTO users
          VALUES (@ssn,@uname,@lname,@phone,@hesCode,@is_admin);
        ''',
        substitutionValues: {
          'ssn': ssnController.text,
          'uname': nameController.text,
          'lname': surnameController.text,
          'phone': phoneController.text,
          'hesCode': hesCodeController.text,
          'is_admin': 0,
        },
      );
      return 1;
    } catch (e) {
      return -1;
    }
  }
}

Future updateUser(String ssn) async {
  searchedList = null;
  await getSingleUser(ssn);
  var oldUser = searchedList[0];
  await connection.query(
    '''
        UPDATE users
        SET uname = @uname, lname = @lname,
        phone = @phone, hesCode = @hesCode 
        WHERE ssn = @ssn;
      ''',
    substitutionValues: {
      'ssn': ssn,
      'uname':
          (nameController.text.isNotEmpty) ? nameController.text : oldUser[1],
      'lname': (surnameController.text.isNotEmpty)
          ? surnameController.text
          : oldUser[2],
      'phone':
          (phoneController.text.isNotEmpty) ? phoneController.text : oldUser[3],
      'hesCode': (hesCodeController.text.isNotEmpty)
          ? hesCodeController.text
          : oldUser[4],
    },
  );
}

Future updateAdminAuth(String ssn) async {
  int newAuthority;

  await getSingleUser(ssn);
  if (searchedList[0][5] == 1) {
    newAuthority = 0;
  } else {
    newAuthority = 1;
  }

  await connection.query(
    '''
        UPDATE users
        SET is_admin = @is_admin
        WHERE ssn = @ssn;
      ''',
    substitutionValues: {
      'ssn': ssn,
      'is_admin': newAuthority,
    },
  );
  return 1;
}

Future deleteUser(String ssn) async {
  searchedList = null;
  searchedList = await connection.query(
    '''
      DELETE FROM users
      WHERE ssn=@ssn;
    ''',
    substitutionValues: {
      'ssn': ssn,
    },
  );
}

// Camping Management
Future getAllCamps() async {
  var count;
  searchedList = null;

  count = await connection.query(
    '''
      SELECT count(*) FROM camping
    ''',
  );

  if (count[0][0] == 0) {
    searchedList = null;
  } else {
    searchedList = await connection.query(
      '''
        SELECT *
        FROM camping
      ''',
    );
  }
}

Future getSingleCamp(int id) async {
  var count;
  searchedList = null;

  count = await connection.query(
    '''
      SELECT count(*)
      FROM camping
      WHERE cid=@cid;
    ''',
    substitutionValues: {
      'cid': id,
    },
  );

  if (count[0][0] == 0) {
    searchedList = null;
  } else {
    searchedList = await connection.query(
      '''
      SELECT * 
      FROM camping
      WHERE cid=@cid;
      ''',
      substitutionValues: {
        'cid': id,
      },
    );
  }
}

Future<int> addNewCamp(bool tentValue) async {
  if (nameController.text.isEmpty ||
      cityController.text.isEmpty ||
      dailyPriceController.text.isEmpty ||
      capacityController.text.isEmpty) {
    return 0;
  } else {
    try {
      await connection.query(
        '''
          INSERT INTO camping
          VALUES (nextval('seqCmp'),@cname,@city,@dailyprice,@tent,@capacity);
        ''',
        substitutionValues: {
          'cname': nameController.text,
          'city': cityController.text,
          'dailyprice': int.parse(dailyPriceController.text),
          'tent': tentValue,
          'capacity': int.parse(capacityController.text),
        },
      );
      return 1;
    } catch (e) {
      return -1;
    }
  }
}

Future updateCamp(int id, bool tentExist) async {
  searchedList = null;
  await getSingleCamp(id);
  var oldCamp = searchedList[0];
  await connection.query(
    '''
        UPDATE camping
        SET cname = @cname, city = @city,
        dailyprice = @dailyprice,
        tent = @tent,
        WHERE cid = @id;
      ''',
    substitutionValues: {
      'cid': id,
      'cname':
          (nameController.text.isNotEmpty) ? nameController.text : oldCamp[1],
      'dailyPrice': (dailyPriceController.text.isNotEmpty)
          ? dailyPriceController.text
          : oldCamp[3],
      'tent': tentExist,
    },
  );
}

Future deleteCamp(int id) async {
  searchedList = null;
  searchedList = await connection.query(
    '''
      DELETE FROM camping
      WHERE cid=@cid;
    ''',
    substitutionValues: {
      'cid': id,
    },
  );
}

Future searchForCamp(bool tentValue) async {
  var campNameSearch;
  var citynameSearch;
  var tentExistSearch;
  var maxPriceSearch;
  var minPriceSearch;
  var campIdSearch;

  if (nameController.text.isNotEmpty) {
    campNameSearch = await connection.query(
      '''
    SELECT *
      FROM camping
      WHERE cname=@cname;
    ''',
      substitutionValues: {
        'cname': nameController.text,
      },
    );
  }

  if (cityController.text.isNotEmpty) {
    campNameSearch = await connection.query(
      '''
    SELECT *
      FROM camping
      WHERE city=@city;
    ''',
      substitutionValues: {
        'city': cityController.text,
      },
    );
  }

  if (tentValue != null) {
    tentExistSearch = await connection.query(
      '''
    SELECT *
      FROM camping
      WHERE tent=@tent;
    ''',
      substitutionValues: {
        'tent': tentValue,
      },
    );
  }

  if (maxPriceController.text.isNotEmpty) {
    maxPriceSearch = await connection.query(
      '''
    SELECT *
      FROM camping
      WHERE dailyPrice < @max;
    ''',
      substitutionValues: {
        'max': int.parse(maxPriceController.text),
      },
    );
  }

  if (minPriceController.text.isNotEmpty) {
    minPriceSearch = await connection.query(
      '''
    SELECT *
      FROM camping
      WHERE dailyPrice > @min;
    ''',
      substitutionValues: {
        'min': int.parse(minPriceController.text),
      },
    );
  }

  if (idController.text.isNotEmpty) {
    campIdSearch = await connection.query(
      '''
    SELECT *
      FROM camping
      WHERE cid=@cid;
    ''',
      substitutionValues: {
        'cid': int.parse(idController.text),
      },
    );
  }
}

// === USER FUNCTIONS ===
Future getUserRsv(String ssn) async {
  var count;
  searchedList = null;

  count = await connection.query(
    '''
      SELECT count(*)
      FROM reservation r, users u
      WHERE r.ussn=u.ssn AND r.ussn=@ssn;
    ''',
    substitutionValues: {
      'ssn': ssn,
    },
  );

  if (count[0][0] == 0) {
    searchedList = null;
  } else {
    searchedList = await connection.query(
      '''
      SELECT *
      FROM reservation r, users u
      WHERE r.ussn=u.ssn AND r.ussn=@ssn
      ORDER BY startDate;
    ''',
      substitutionValues: {
        'ssn': ssn,
      },
    );
  }
}

Future<int> addNewUserRsv(bool tent) async {
  if (idController.text.isEmpty ||
      dateController.text.isEmpty ||
      dayController.text.isEmpty) {
    return 0;
  } else {
    try {
      print(idController.text);
      print(dateController.text);
      print(dayController.text);
      searchedList = await connection.query(
        '''
          INSERT INTO reservation
          VALUES (nextval('seqrsv') ,@ussn,@campingid,@startdate,@dayamount,@tent,@pcount);
        ''',
        substitutionValues: {
          'ussn': currentUser.ssn,
          'campingid': idController.text,
          'startdate': DateFormat('yyyy.MM.dd').parse(dateController.text),
          'dayamount': dayController.text,
          'tent': tent,
          'pcount': pcountController.text
        },
      );
      return 1;
    } catch (e) {
      print(searchedList);
      print(e);
      return -1;
    }
  }
}

Future deleteRsv(int id) async {
  searchedList = null;
  searchedList = await connection.query(
    '''
      DELETE FROM reservation
      WHERE rid=@rid;
    ''',
    substitutionValues: {
      'rid': id,
    },
  );
}

// === GENERAL FUNCTIONS ===
Future<int> loginCheck(String ssn) async {
  var count;
  var checkedUser;
  searchedList = null;

  count = await connection.query(
    '''
      SELECT count(*)
      FROM users
      WHERE ssn=@ssn;
    ''',
    substitutionValues: {
      'ssn': ssn,
    },
  );

  if (count[0][0] == 0) {
    searchedList = null;
  } else {
    searchedList = await connection.query(
      '''
      SELECT *
      FROM users
      WHERE ssn=@ssn;
    ''',
      substitutionValues: {
        'ssn': ssn,
      },
    );
  }
  if (searchedList != null) {
    checkedUser = searchedList[0];
    currentUser.ssn = ssn;
    currentUser.name = checkedUser[1];
    currentUser.surname = checkedUser[2];
    currentUser.phone = checkedUser[3];
    currentUser.hesCode = checkedUser[4];
    currentUser.isAdmin = checkedUser[5];
    if (currentUser.isAdmin == 1) {
      return 1;
    } else {
      return 0;
    }
  } else {
    return -1;
  }
}

Future clearAllControllers() async {
  ssnController.clear();
  nameController.clear();
  surnameController.clear();
  phoneController.clear();
  hesCodeController.clear();

  idController.clear();
  campNameController.clear();
  cityController.clear();
  capacityController.clear();
  dailyPriceController.clear();
  dateController.clear();
  dayController.clear();
  tentController.clear();
  tentPriceController.clear();

  maxPriceController.clear();
  minPriceController.clear();
}

// Future<String> getCamp(int campId) async {
//   searchedList = null;
//   searchedList = await connection.query(
//     '''
//     SELECT cName 
//     FROM camping
//     WHERE campingId=@campId;
//     ''',
//     substitutionValues: {
//       'campId': campId,
//     },
//   );
//   return searchedList[0][0];
// }

// Future getReservations() async {
//   var campNameSearch;
//   var cityNameSearch;
//   var dateSearch;
//   var ssnSearch;
//   searchedList = null;
//   ssnSearch = await connection.query(
//     '''
//     SELECT rId,ussn, campingId, startDate,dayAmount,tent,totalCost,pcount
//     FROM reservation
//     WHERE ussn=@ussn;
//     ''',
//     substitutionValues: {
//       'ussn': ssnController.text,
//     },
//   );
//   campNameSearch = await connection.query(
//     '''
//     SELECT rId,ussn, campingId, startDate,dayAmount,tent,totalCost,pcount
//     FROM reservation,camping
//     WHERE cName=@campName AND campingId=cID;
//     ''',
//     substitutionValues: {
//       'campName': campNameController.text,
//     },
//   );
//   cityNameSearch = await connection.query(
//     '''
//     SELECT rId,ussn, campingId, startDate,dayAmount,tent,totalCost,pcount
//     FROM reservation,camping
//     WHERE city=@city AND campingId=cId;
//     ''',
//     substitutionValues: {
//       'city': cityController.text,
//     },
//   );
//   dateSearch = await connection.query(
//     '''
//     SELECT rId,ussn, campingId, startDate,dayAmount,tent,totalCost,pcount
//     FROM reservation
//     WHERE startDate=@date;
//     ''',
//     substitutionValues: {
//       'date': dateController.text,
//     },
//   );
//   if (dateSearch[0] == '' &&
//       cityNameSearch[0] == '' &&
//       campNameSearch[0] == '' &&
//       ssnSearch[0] == '') {
//     searchedList = null;
//   }
// }

// Future getAllReservations() async {
//   searchedList = null;
//   searchedList = await connection.query('''
//     SELECT * FROM reservation
//     ''');
// }

// Future getSingleUserRsv(String ssn) async {
//   var count;
//   searchedList = null;
//   count = await connection.query(
//     '''
//       SELECT count(*)
//       FROM users
//       WHERE ssn=@ssn;
//     ''',
//     substitutionValues: {
//       'ssn': ssn,
//     },
//   );
//   if (count[0][0] == 0) {
//     searchedList = null;
//   } else {
//     searchedList = await connection.query(
//       '''
//       SELECT *
//       FROM users
//       WHERE ssn=@ssn;
//     ''',
//       substitutionValues: {
//         'ssn': ssn,
//       },
//     );
//   }
// }

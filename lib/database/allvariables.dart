import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'allclasses.dart';

// BURAYA TÜM DEĞİŞKENLERİ YAZABİLİRİZ

var searchedList;
var row;

List<User> userList = [];

var connection = PostgreSQLConnection(
  '10.0.2.2',
  5432,
  'getCamped_db',
  username: 'postgres',
  password: '0000',
);

var currentUser = User();

var currentCamp = Camp(
  id: 0987654321,
  name: 'MyCamp.com',
  city: 'İstanbul',
  capacity: 100,
  dailyPrice: 20,
  tent: true,
  tentPrice: 10,
);

var ssnfilter = '''
    SELECT *
    FROM reservation
    WHERE ussn=@ssn;
''';

var cNamefilter = '''
    SELECT *
    FROM reservation
    WHERE campName=@cname;
''';

var ssnController = TextEditingController();
var nameController = TextEditingController();
var surnameController = TextEditingController();
var phoneController = TextEditingController();
var hesCodeController = TextEditingController();

var idController = TextEditingController();
var campNameController = TextEditingController();
var cityController = TextEditingController();
var capacityController = TextEditingController();
var dailyPriceController = TextEditingController();
var dateController = TextEditingController();
var dayController = TextEditingController();
var pcountController = TextEditingController();
var tentController = TextEditingController();
var tentPriceController = TextEditingController();

var maxPriceController = TextEditingController();
var minPriceController = TextEditingController();

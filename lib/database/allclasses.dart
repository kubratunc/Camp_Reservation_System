// BURADA GEREKLİ SINIFLARI OLUŞTURABİLİRİZ

class User {
  String? ssn;
  String? name;
  String? surname;
  String? phone;
  String? hesCode;
  int? isAdmin;

  User({
    this.ssn,
    this.name,
    this.surname,
    this.phone,
    this.hesCode,
    this.isAdmin,
  });
}

class Camp {
  int? id;
  String? name;
  String? city;
  int? capacity;
  double? dailyPrice;
  bool? tent;
  double? tentPrice;

  Camp({
    this.id,
    this.name,
    this.city,
    this.capacity,
    this.dailyPrice,
    this.tent,
    this.tentPrice,
  });
}

class Rsv {
  int? id;
  String? ussn;
  String? campingId;
  String? startDate;
  int? dayAmount;
  bool? tent;
  double? totalCost;
  int? pCount;

  Rsv({
    this.id,
    this.ussn,
    this.campingId,
    this.startDate,
    this.dayAmount,
    this.tent,
    this.totalCost,
    this.pCount,
  });
}

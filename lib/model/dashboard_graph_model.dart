class DashboardGraphModel {
  List<Packs>? packs;
  List<Credits>? credits;

  DashboardGraphModel({this.packs, this.credits});

  DashboardGraphModel.fromJson(Map<String, dynamic> json) {
    if (json['packs'] != null) {
      packs = <Packs>[];
      json['packs'].forEach((v) {
        packs!.add(new Packs.fromJson(v));
      });
    }
    if (json['credits'] != null) {
      credits = <Credits>[];
      json['credits'].forEach((v) {
        credits!.add(new Credits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.packs != null) {
      data['packs'] = this.packs!.map((v) => v.toJson()).toList();
    }
    if (this.credits != null) {
      data['credits'] = this.credits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Packs {
  String? name;
  List<Data>? data;

  Packs({this.name, this.data});

  Packs.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? pack;
  String? date;

  Data({this.pack, this.date});

  Data.fromJson(Map<String, dynamic> json) {
    pack = json['pack'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pack'] = this.pack;
    data['date'] = this.date;
    return data;
  }
}

class Credits {
  String? name;
  List<Datas>? data;

  Credits({this.name, this.data});

  Credits.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['data'] != null) {
      data = <Datas>[];
      json['data'].forEach((v) {
        data!.add(new Datas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datas {
  double? credit;
  String? date;

  Datas({this.credit, this.date});

  Datas.fromJson(Map<String, dynamic> json) {
    credit = double.parse(json['credit']);
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['credit'] = this.credit;
    data['date'] = this.date;
    return data;
  }
}

//dtYkuAczQnuDtHA1XEMl0W:APA91bH66GLSZfIO5S6Ao115hB1kBWKnqRUgSkuQl-t6XOinPzWQOwA30KnQVbBvqYb5QJa6QfUL9CCsHbeJbShlc4axGKW3XzSxEEJsC1t_3GbV0aQvo86uEJ8q4krcBd3jLiR4g7qY
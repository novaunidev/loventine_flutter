class BankAccountPersonal {
  String? sId;
  String? user;
  String? name;
  String? accountNumber;
  String? ownerName;
  int? iV;

  BankAccountPersonal(
      {this.sId,
      this.user,
      this.name,
      this.accountNumber,
      this.ownerName,
      this.iV});

  BankAccountPersonal.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    name = json['name'];
    accountNumber = json['accountNumber'];
    ownerName = json['ownerName'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['name'] = this.name;
    data['accountNumber'] = this.accountNumber;
    data['ownerName'] = this.ownerName;
    data['__v'] = this.iV;
    return data;
  }
}
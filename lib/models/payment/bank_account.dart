class BankAccount {
  String? sId;
  String? name;
  String? logoImg;
  String? qrCodeImg;
  String? accountNumber;
  String? ownerName;
  int? iV;

  BankAccount(
      {this.sId,
      this.name,
      this.logoImg,
      this.qrCodeImg,
      this.accountNumber,
      this.ownerName,
      this.iV});

  BankAccount.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    logoImg = json['logoImg'];
    qrCodeImg = json['qrCodeImg'];
    accountNumber = json['accountNumber'];
    ownerName = json['ownerName'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['logoImg'] = this.logoImg;
    data['qrCodeImg'] = this.qrCodeImg;
    data['accountNumber'] = this.accountNumber;
    data['ownerName'] = this.ownerName;
    data['__v'] = this.iV;
    return data;
  }
}

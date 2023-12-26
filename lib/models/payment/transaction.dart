class Transaction {
  String? sId;
  String? user;
  String? content;
  double? money;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Transaction(
      {this.sId,
      this.user,
      this.content,
      this.money,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Transaction.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    content = json['content'];
    money = double.parse(json['money'].toString());
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['content'] = this.content;
    data['money'] = this.money;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Bill {
  String? sId;
  String? consultingJob;
  String? user;
  String? content;
  String? adviseType;
  int? money;
  int? countPaid;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Bill(
      {this.sId,
      this.consultingJob,
      this.user,
      this.content,
      this.adviseType,
      this.money,
      this.countPaid,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Bill.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    consultingJob = json['consultingJob'];
    user = json['user'];
    content = json['content'];
    adviseType = json['adviseType'];
    money = json['money'];
    countPaid = json['countPaid'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['consultingJob'] = this.consultingJob;
    data['user'] = this.user;
    data['content'] = this.content;
    data['adviseType'] = this.adviseType;
    data['money'] = this.money;
    data['countPaid'] = this.countPaid;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

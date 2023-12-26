class BillPaySuggest {
  bool? isPayAccecpt;
  String? suggestText;

  BillPaySuggest({this.isPayAccecpt, this.suggestText});

  BillPaySuggest.fromJson(Map<String, dynamic> json) {
    isPayAccecpt = json['isPayAccecpt'];
    suggestText = json['suggestText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isPayAccecpt'] = this.isPayAccecpt;
    data['suggestText'] = this.suggestText;
    return data;
  }
}

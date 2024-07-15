class SubscriptionYearlyModel {
  String? message;
  Data? data;

  SubscriptionYearlyModel({this.message, this.data});

  SubscriptionYearlyModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? subscriptionStartDate;
  String? subscriptionEndDate;
  String? status;

  Data(
      {this.name,
        this.subscriptionStartDate,
        this.subscriptionEndDate,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subscriptionStartDate = json['subscriptionStartDate'];
    subscriptionEndDate = json['subscriptionEndDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['subscriptionStartDate'] = this.subscriptionStartDate;
    data['subscriptionEndDate'] = this.subscriptionEndDate;
    data['status'] = this.status;
    return data;
  }
}

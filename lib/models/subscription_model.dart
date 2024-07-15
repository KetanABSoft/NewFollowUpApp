class SubscriptionModel {
  String? name;
  String? subscriptionStartDate;
  String? subscriptionEndDate;
  String? status;

  SubscriptionModel(
      {this.name,
        this.subscriptionStartDate,
        this.subscriptionEndDate,
        this.status});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
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

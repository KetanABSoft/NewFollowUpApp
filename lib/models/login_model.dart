class LoginModel {
  String? message;
  String? token;
  String? subscriptionStatus;
  String? registrationStatus;

  LoginModel(
      {this.message,
        this.token,
        this.subscriptionStatus,
        this.registrationStatus});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    subscriptionStatus = json['subscriptionStatus'];
    registrationStatus = json['registrationStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    data['subscriptionStatus'] = this.subscriptionStatus;
    data['registrationStatus'] = this.registrationStatus;
    return data;
  }
}

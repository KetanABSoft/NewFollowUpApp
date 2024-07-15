class RegisterModel {
  String? message;
  Data? data;

  RegisterModel({this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
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
  String? registrationDate;
  String? registrationEndDate;
  String? status;

  Data(
      {this.name,
        this.registrationDate,
        this.registrationEndDate,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    registrationDate = json['registrationDate'];
    registrationEndDate = json['registrationEndDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['registrationDate'] = this.registrationDate;
    data['registrationEndDate'] = this.registrationEndDate;
    data['status'] = this.status;
    return data;
  }
}

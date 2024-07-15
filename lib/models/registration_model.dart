class RegistrationModel {
  String? name;
  String? registrationDate;
  String? registrationEndDate;
  String? status;

  RegistrationModel(
      {this.name,
        this.registrationDate,
        this.registrationEndDate,
        this.status});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
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

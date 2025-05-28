class DoctorModel {
  String? doctorId;
  String? doctorName;
  String? doctorEmail;
  String? doctorPassword;
  String? doctorPhone;
  String? doctorCreate;
  String? doctorImage;
  String? specialization;
  String? experience;
  String? categoryId;

  DoctorModel({
    this.doctorId,
    this.doctorName,
    this.doctorEmail,
    this.doctorPassword,
    this.doctorPhone,
    this.doctorCreate,
    this.doctorImage,
    this.specialization,
    this.experience,
    this.categoryId,
  });

  DoctorModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'].toString();
    doctorName = json['doctor_name'];
    doctorEmail = json['doctor_email'];
    doctorPassword = json['doctor_password'];
    doctorPhone = json['doctor_phone'];
    doctorCreate = json['doctor_create'];
    doctorImage = json['doctor_image'];
    specialization = json['specialization'];
    experience = json['experience'];
    categoryId = json['category_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_id'] = doctorId;
    data['doctor_name'] = doctorName;
    data['doctor_email'] = doctorEmail;
    data['doctor_password'] = doctorPassword;
    data['doctor_phone'] = doctorPhone;
    data['doctor_create'] = doctorCreate;
    data['doctor_image'] = doctorImage;
    data['specialization'] = specialization;
    data['experience'] = experience;
    data['category_id'] = categoryId;
    return data;
  }
}

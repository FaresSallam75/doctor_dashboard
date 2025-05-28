class AppointmentModel {
  String? appointmentId;
  String? appointmentDate;
  String? appointmentStatus;
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
  String? userId;
  String? userName;
  String? userEmail;
  String? userPassword;
  String? userPhone;
  String? userCreate;
  String? userImage;

  AppointmentModel({
    this.appointmentId,
    this.appointmentDate,
    this.appointmentStatus,
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
    this.userId,
    this.userName,
    this.userEmail,
    this.userPassword,
    this.userPhone,
    this.userCreate,
    this.userImage,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'].toString();
    appointmentDate = json['appointment_date'];
    appointmentStatus = json['appointment_status'];
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
    userId = json['user_id'].toString();
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPassword = json['user_password'];
    userPhone = json['user_phone'];
    userCreate = json['user_create'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointment_id'] = appointmentId;
    data['appointment_date'] = appointmentDate;
    data['appointment_status'] = appointmentStatus;
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
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['user_password'] = userPassword;
    data['user_phone'] = userPhone;
    data['user_create'] = userCreate;
    data['user_image'] = userImage;
    return data;
  }
}

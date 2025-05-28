class MessageModel {
  String? messageId;
  String? sender;
  String? receiver;
  String? text;
  String? file;
  String? date;
  String? userId;
  String? userName;
  String? userEmail;
  String? userPassword;
  String? userPhone;
  String? userCreate;
  String? userImage;
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

  MessageModel({
    this.messageId,
    this.sender,
    this.receiver,
    this.text,
    this.file,
    this.date,
    this.userId,
    this.userName,
    this.userEmail,
    this.userPassword,
    this.userPhone,
    this.userCreate,
    this.userImage,
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

  MessageModel.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'].toString();
    sender = json['sender'].toString();
    receiver = json['receiver'].toString();
    text = json['text'];
    file = json['file'];
    date = json['date'];
    userId = json['user_id'].toString();
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPassword = json['user_password'].toString();
    userPhone = json['user_phone'].toString();
    userCreate = json['user_create'];
    userImage = json['user_image'];
    doctorId = json['doctor_id'].toString();
    doctorName = json['doctor_name'];
    doctorEmail = json['doctor_email'];
    doctorPassword = json['doctor_password'];
    doctorPhone = json['doctor_phone'].toString();
    doctorCreate = json['doctor_create'];
    doctorImage = json['doctor_image'];
    specialization = json['specialization'];
    experience = json['experience'];
    categoryId = json['category_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_id'] = messageId;
    data['sender'] = sender;
    data['receiver'] = receiver;
    data['text'] = text;
    data['file'] = file;
    data['date'] = date;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['user_password'] = userPassword;
    data['user_phone'] = userPhone;
    data['user_create'] = userCreate;
    data['user_image'] = userImage;
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

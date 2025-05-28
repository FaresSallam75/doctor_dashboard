class AppLink {
  static String linkServerName = "http://10.0.2.2/doctor_appointment";
  static String linkImageStatic = "http://10.0.2.2/doctor_appointment/upload";

  // images
  static String viewDoctorImage = "$linkImageStatic/doctors";
  static String viewUserImage = "$linkImageStatic/users";
  static String viewMessagesImages = "$linkImageStatic/messages";

  // auth
  static String register = "$linkServerName/doctor/auth/signup.php";
  static String login = "$linkServerName/doctor/auth/login.php";
  static String doctorDetails = "$linkServerName/doctor/auth/details.php";
  static String viewDoctorDetails =
      "$linkServerName/doctor/auth/viewdetails.php";
  static String currentDoctor = "$linkServerName/doctor/auth/currentdoctor.php";
  static String editCurrentDoctor =
      "$linkServerName/doctor/auth/updatedoctor.php";

  static String checkEmail = "$linkServerName/doctor/forgetpassword/checkemail.php";
  static String resetPassword = "$linkServerName/doctor/forgetpassword/resetpassword.php";


  // chat
  static String viewCardMessages =
      "$linkServerName/doctor/message/cardmessage.php";
  static String viewAllMessages =
      "$linkServerName/doctor/message/viewmessage.php";
  static String sendMessages = "$linkServerName/doctor/message/sendmessage.php";
  static String usertoken = "$linkServerName/auth/token.php";

  // appointment
  static String getAppointment = "$linkServerName/doctor/appointments/view.php";
  static String getNextAppointment =
      "$linkServerName/doctor/appointments/next.php";

  static String cancelAppointment =
      "$linkServerName/doctor/appointments/cancel.php";

  static String completeAppointment =
      "$linkServerName/doctor/appointments/complete.php";
  static String approveAppointment =
      "$linkServerName/doctor/appointments/approve.php";

  static String viewUserPayment =
      "$linkServerName/payment/view2.php";

}

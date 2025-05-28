import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_appointment/business_logic/auth/signup_cubit.dart';
import 'package:user_appointment/business_logic/auth/signup_state.dart';
import 'package:user_appointment/constants/colors.dart';
import 'package:user_appointment/constants/showalertdialog.dart';
import 'package:user_appointment/constants/styles.dart';
import 'package:user_appointment/constants/validinput.dart';
import 'package:user_appointment/presentation/screens/auth/login.dart';
import 'package:user_appointment/presentation/widgets/auth/customdropdownbutton.dart';
import 'package:user_appointment/presentation/widgets/auth/customelevatedbutton.dart';
import 'package:user_appointment/presentation/widgets/auth/customtextformfield.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? selectedSpecialist;
  String? startTime;
  String? endTime;
  bool _isPasswordVisible = false;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  final Map<String, String> specialists = {
    "1": 'Pediatrician',
    "2": 'Cardiologist',
    "3": 'Dermatologist',
    "4": 'Endocrinologist',
    "5": 'Neurosurgeon',
    "6": 'Ophthalmologist',
    "7": 'Radiologist',
    "8": 'Rheumatologists',
    "9": 'Gastroenterologist',
    "10": 'Psychiatrist',
  };

  late TextEditingController doctorName;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController phone;
  late TextEditingController specialization;
  late TextEditingController experience;
  late TextEditingController specialty;
  late TextEditingController startDoctorTime;
  late TextEditingController endDoctorTime;

  @override
  void initState() {
    doctorName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    phone = TextEditingController();
    specialization = TextEditingController();
    experience = TextEditingController();
    specialty = TextEditingController();
    startDoctorTime = TextEditingController();
    endDoctorTime = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    doctorName.dispose();
    email.dispose();
    password.dispose();
    phone.dispose();
    specialization.dispose();
    experience.dispose();
    specialty.dispose();
    startDoctorTime.dispose();
    endDoctorTime.dispose();
    formState.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F2F5),
      body: SafeArea(
        child: Padding(
          // Add horizontal padding to the content
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              if (state is SignUpStateLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SignUpStateLoaded) {
                return bodyDetails();
              } else {
                return Center(child: Text("No Data ..."));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget bodyDetails() {
    return SingleChildScrollView(
      child: Form(
        key: formState,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40.0),

            Text('Sign Up', style: largeStyle),
            SizedBox(height: 12.0), // Space below title
            // --- Don't have an account? Link ---
            Row(
              children: <Widget>[
                Text("Already have an account? ", style: meduimStyle),
                // Use GestureDetector for tappable text without button padding
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text(
                    'Sign in!',
                    style: meduimStyle.copyWith(color: Colors.blue.shade600),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0), // Larger space before inputs
            // --- Email Input ---
            CustomTextForm(
              hintText: "Username*",
              controller: doctorName,
              validator: (value) {
                return validInput(value!, 4, 20, "username");
              },
              obscureText: false,
              suffixIcon: null,
            ),
            SizedBox(height: 16.0), // Space between inputs
            // --- Password Input ---
            CustomTextForm(
              hintText: "Email*",
              controller: email,
              validator: (value) {
                return validInput(value!, 4, 20, "email");
              },
              obscureText: false,
              suffixIcon: null,
            ),
            SizedBox(height: 16.0), // Space between inputs
            CustomTextForm(
              hintText: "Password*",
              controller: password,
              validator: (value) {
                return validInput(value!, 4, 20, "password");
              },
              obscureText: !_isPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                      // ignore: dead_code
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey.shade500,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            SizedBox(height: 16.0), // Space between inputs
            CustomTextForm(
              hintText: "Phone*",
              controller: phone,
              validator: (value) {
                return validInput(value!, 4, 20, "phone");
              },
              obscureText: false,
              suffixIcon: null,
            ),
            SizedBox(height: 16.0), // Space between inputs
            CustomTextForm(
              hintText: "Specialization*",
              controller: specialization,
              validator: (value) {
                return validInput(value!, 4, 20, "");
              },
              obscureText: false,
              suffixIcon: null,
            ),
            SizedBox(height: 16.0), // Space before button
            CustomTextForm(
              hintText: "Experience*",
              controller: experience,
              validator: (value) {
                return validInput(value!, 1, 5, "");
              },
              obscureText: false,
              suffixIcon: null,
            ),
            SizedBox(height: 16.0), // Space before button
            CustomDropdownButton(
              hint: "Select Specialty",
              icon: Icons.medical_services_outlined,
              value: selectedSpecialist,
              items: specialists,
              onChanged:
                  (val) => setState(() {
                    selectedSpecialist = val;
                    print("selectedSpecialist ==== $selectedSpecialist");
                  }),
            ),
            //  SizedBox(height: 15.0), // Space before button

            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     Expanded(
            //       child: CustomDropdownButtonAvailableTimes(
            //         hint: "Start Time*",
            //         icon: Icons.access_time,
            //         value: startTime,
            //         items: availableTimes,
            //         onChanged:
            //             (val) => setState(() {
            //               startTime = val;
            //               print("Start Time ==== $startTime");
            //             }),
            //       ),
            //     ),
            //     SizedBox(width: 5.0),
            //     Expanded(
            //       child: CustomDropdownButtonAvailableTimes(
            //         hint: "End Time*",
            //         icon: Icons.access_time,
            //         value: endTime,
            //         items: availableTimes,
            //         onChanged:
            //             (val) => setState(() {
            //               endTime = val;
            //               print("End Time ==== $endTime");
            //             }),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 32.0), // Space before button
            // --- Sign In Button ---
            CustomElevatedButton(
              backgroundColor: Colors.blue.shade600,
              foregroundColor: MyColors.white,
              width: double.infinity,
              onPressed: () {
                if (formState.currentState!.validate()) {
                  context.read<SignUpCubit>().signup(
                    context,
                    doctorName.text,
                    email.text,
                    password.text,
                    phone.text,
                    specialization.text,
                    experience.text,
                    selectedSpecialist!,
                  );
                  // continueDoctorDetails();
                } else {
                  showAlertDialog(
                    context,
                    "alert",
                    "Check Your Input",
                    () {
                      Navigator.of(context).pop();
                    },
                    () {
                      Navigator.of(context).pop();
                    },
                  );
                }
              },
              child: Text(
                'Sign Up',
                style: meduimStyle.copyWith(color: MyColors.bg, fontSize: 19.0),
              ),
            ),

            // Use Spacer to push content up if the screen is tall,
            // or remove if you want content centered regardless of height
            // Spacer(),
          ],
        ),
      ),
    );
  }
}

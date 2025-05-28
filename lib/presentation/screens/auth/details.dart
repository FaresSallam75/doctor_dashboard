import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_appointment/business_logic/auth/login_cubit.dart';
import 'package:user_appointment/business_logic/auth/signup_cubit.dart';
import 'package:user_appointment/business_logic/auth/signup_state.dart';
import 'package:user_appointment/constants/colors.dart';
import 'package:user_appointment/constants/location.dart';
import 'package:user_appointment/constants/route.dart';
import 'package:user_appointment/constants/showalertdialog.dart';
import 'package:user_appointment/constants/styles.dart';
import 'package:user_appointment/constants/validinput.dart';
import 'package:user_appointment/main.dart' show myBox;
import 'package:user_appointment/presentation/widgets/auth/customdropdownbutton.dart';
import 'package:user_appointment/presentation/widgets/auth/customelevatedbutton.dart';
import 'package:user_appointment/presentation/widgets/auth/customtextformfield.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String? startTime;
  String? endTime;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  final bool _isInit = false;
  late TextEditingController degreeController;
  late TextEditingController priceController;
  late TextEditingController daysController;

  // String? token;
  // String? doctorId;

  final List<String> availableTimes = [
    "9:00 AM", "9:30 AM", "10:00 AM", "10:30 AM",
    "11:00 AM", "11:30 AM", "12:00 PM", "12:30 PM",
    "1:00 PM", "1:30 PM", "2:00 PM", "2:30 PM",
    "3:00 PM", "3:30 PM", "4:00 PM", "4:30 PM",
    "5:00 PM",
    // Add more times as needed
  ];

  @override
  void initState() {
    waitingData();
    getDoctorLocation();
    degreeController = TextEditingController();
    priceController = TextEditingController();
    daysController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    degreeController.dispose();
    priceController.dispose();
    daysController.dispose();
    super.dispose();
  }

  waitingData() async {
    if (myBox!.get("doctorId").toString() ==
        context.read<LoginCubit>().doctorId.toString()) {
      return;
    } else {
      await context.read<LoginCubit>().getUserToken();
      await context.read<LoginCubit>().viewDoctorDeatils();
      await autoMove();
      print(
        "context.read<LoginCubit>().doctorId =====${context.read<LoginCubit>().doctorId}",
      );
      print(
        "context.read<LoginCubit>().token =====${context.read<LoginCubit>().token}",
      );
    }
  }

  // @override
  // void didChangeDependencies() {
  //   if (!_isInit) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       final args =
  //           ModalRoute.of(context)!.settings.arguments as Map<String, String>;
  //       token = args['token'];
  //       doctorId = args['doctorId'];
  //       print("doctorId ================================== $doctorId");
  //       print("token ================================== $token");
  //       _isInit = true;
  //     });
  //   }
  //   super.didChangeDependencies();
  // }

  autoMove() {
    if (myBox!.get("doctorId").toString() ==
        context.read<LoginCubit>().doctorId.toString()) {
      Navigator.of(context).pushReplacementNamed(AppRotes.homePage);
    }
  }

  getDoctorLocation() async {
    await requestPermissionLocation(context);
    await getCurrentUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F2F5),
      //appBar: AppBar(title: Text("Details"), centerTitle: true),
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
            Text('Complete Your Profile', style: largeStyle),
            SizedBox(height: 8.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'If you have entered this data before',
                  style: meduimStyle,
                ),
                SizedBox(width: 5.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(AppRotes.homePage);
                  },
                  child: Text(
                    'Skip',
                    style: meduimStyle.copyWith(
                      color: MyColors.blueDark,
                      decorationColor: MyColors.secondColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0), // Space below title

            SizedBox(height: 30.0), // Larger space before inputs
            // --- Email Input ---
            CustomTextForm(
              hintText: "Degree* (Optinal)",
              controller: degreeController,
              validator: (value) {
                return validInput(value!, 2, 20, "");
              },
              obscureText: false,
              suffixIcon: null,
            ),
            SizedBox(height: 16.0),
            CustomTextForm(
              hintText: "Price*",
              controller: priceController,
              validator: (value) {
                return validInput(value!, 2, 20, "");
              },
              obscureText: false,
              suffixIcon: null,
            ),
            SizedBox(height: 16.0), // Space between inputs
            // --- Password Input ---
            CustomTextForm(
              hintText: "Days (In Week)*",
              controller: daysController,
              validator: (value) {
                return validInput(value!, 1, 20, "");
              },
              obscureText: false,
              suffixIcon: null,
            ),
            SizedBox(height: 16.0), // Space between inputs
            // Space before button
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CustomDropdownButtonAvailableTimes(
                    hint: "Start Time*",
                    icon: Icons.access_time,
                    value: startTime,
                    items: availableTimes,
                    onChanged:
                        (val) => setState(() {
                          startTime = val;
                          print("Start Time ==== $startTime");
                        }),
                  ),
                ),
                SizedBox(width: 5.0),
                Expanded(
                  child: CustomDropdownButtonAvailableTimes(
                    hint: "End Time*",
                    icon: Icons.access_time,
                    value: endTime,
                    items: availableTimes,
                    onChanged:
                        (val) => setState(() {
                          endTime = val;
                          print("End Time ==== $endTime");
                        }),
                  ),
                ),
              ],
            ),

            SizedBox(height: 32.0), // Space before button
            // --- Sign In Button ---
            CustomElevatedButton(
              backgroundColor: Colors.blue.shade600,
              foregroundColor: MyColors.white,
              width: double.infinity,
              onPressed: () {
                if (formState.currentState!.validate()) {
                  if (myBox!.get("doctorId").toString() ==
                      context.read<LoginCubit>().doctorId.toString()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("You Already Added This Data Before ."),
                      ),
                    );
                  } else {
                    context.read<SignUpCubit>().doctorDetails(
                      context,
                      degreeController.text,
                      priceController.text,
                      daysController.text,
                      startTime!,
                      endTime!,
                      placemarks[0].subAdministrativeArea!,
                      context.read<LoginCubit>().token!,
                    );
                  }
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
                'Continue',
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

// ignore_for_file: void_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_appointment/business_logic/auth/login_cubit.dart';
import 'package:user_appointment/business_logic/auth/login_state.dart';
import 'package:user_appointment/constants/colors.dart';
import 'package:user_appointment/constants/route.dart';
import 'package:user_appointment/constants/styles.dart';
import 'package:user_appointment/constants/validinput.dart';
import 'package:user_appointment/presentation/screens/auth/register.dart';
import 'package:user_appointment/presentation/widgets/auth/customelevatedbutton.dart';
import 'package:user_appointment/presentation/widgets/auth/customtextformfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isPasswordVisible = false;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  void initState() {

    // context.read<LoginCubit>().getUserToken();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    formState.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F2F5),
      // SafeArea prevents UI overlap with status bar/notches
      body: SafeArea(
        child: Padding(
          // Add horizontal padding to the content
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is LoginStateLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is LoginStateLoaded) {
                return loginBodyDetails();
              } else if (state is InternetStateError) {
                return Center(
                  child: Text(
                    " ${state.internetErrorMessage} Check Your Internet Connectivity ...",
                  ),
                );
              } else {
                return Center(child: Text("No Data ..."));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget loginBodyDetails() {
    return Form(
      key: formState,
      child: Column(
        // Align content to the start (left)
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Add some space from the top Safe Area
          SizedBox(height: 60.0),

          // --- Sign In Title ---
          Text('Sign In', style: largeStyle.copyWith(fontSize: 30.0)),
          SizedBox(height: 12.0), // Space below title
          // --- Don't have an account? Link ---
          Row(
            children: <Widget>[
              Text("Don't have an account? ", style: meduimStyle),
              // Use GestureDetector for tappable text without button padding
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: Text(
                  'Sign up!',
                  style: meduimStyle.copyWith(color: Colors.blue.shade600),
                ),
              ),
            ],
          ),
          SizedBox(height: 48.0), // Larger space before inputs
          // --- Email Input ---
          CustomTextForm(
            hintText: "Email*",
            controller: emailController,
            validator: (value) {
              return validInput(value!, 4, 20, "email");
            },
            obscureText: false,
            suffixIcon: null,
          ),
          SizedBox(height: 16.0), // Space between inputs
          // --- Password Input ---
          CustomTextForm(
            hintText: "Password*",
            controller: passwordController,
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
          SizedBox(height: 16.0), // Space below password
          // --- Forgot Password Link ---
          Align(
            // Ensure it stays left-aligned
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
             Navigator.pushReplacementNamed(context, AppRotes.checkEmail);
              },
              child: Text(
                'Forgot your Password?',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey.shade700,
                  // fontWeight: FontWeight.w500, // Optional weight
                ),
              ),
            ),
          ),
          SizedBox(height: 32.0), // Space before button
          // --- Sign In Button ---
          CustomElevatedButton(
            backgroundColor: Colors.blue.shade600,
            foregroundColor: MyColors.white,
            width: double.infinity,
            onPressed: () {
              context.read<LoginCubit>().login(
                context,
                emailController.text,
                passwordController.text,
              );
            },
            child: Text(
              'Sign In',
              style: meduimStyle.copyWith(color: MyColors.bg, fontSize: 19.0),
            ),
          ),
        ],
      ),
    );
  }
}

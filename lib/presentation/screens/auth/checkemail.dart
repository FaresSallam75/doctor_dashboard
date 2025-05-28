
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_appointment/business_logic/auth/login_cubit.dart';
import 'package:user_appointment/constants/colors.dart';
import 'package:user_appointment/constants/styles.dart';
import 'package:user_appointment/constants/validinput.dart';
import 'package:user_appointment/presentation/widgets/auth/resetpassword/custommaterialbutton.dart';
import 'package:user_appointment/presentation/widgets/auth/resetpassword/customtestformfield.dart';

class CheckEmail extends StatefulWidget {
  const CheckEmail({super.key});

  @override
  State<CheckEmail> createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
  late TextEditingController emailController;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    formState.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Email"),
        backgroundColor: MyColors.bg,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text(
              "Please Enter Your Email Address to Reset Password",
              style: smallStyle.copyWith(
                // ignore: deprecated_member_use
                color: MyColors.header01.withOpacity(0.5),
                fontSize: 15.0,
              ),
            ),
          ),
          Form(
            key: formState,
            child: Container(
              margin: EdgeInsets.only(top: 30.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    labelText: "Check Email",
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.email_outlined,
                    validator: (value) {
                      return validInput(value!, 4, 20, "Email");
                    },
                    obscureText: false,
                    controller: emailController,
                    suffixIcon: null,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30.0),
          CustomMaterialButton(
            color: MyColors.header01,
            minWidth: MediaQuery.of(context).size.width - 80,
            onPressed: () async {
              if (formState.currentState!.validate()) {
                context.read<LoginCubit>().checkEmail(
                  context,
                  emailController.text,
                );
              }
            },
            radius: 15.0,
            child: Text(
              "Check Email",
              style: kTitleStyle.copyWith(color: MyColors.bg, fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }

}



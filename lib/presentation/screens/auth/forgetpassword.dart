import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_appointment/business_logic/auth/login_cubit.dart';
import 'package:user_appointment/constants/colors.dart';
import 'package:user_appointment/constants/route.dart';
import 'package:user_appointment/constants/styles.dart';
import 'package:user_appointment/constants/validinput.dart';
import 'package:user_appointment/presentation/widgets/auth/resetpassword/custommaterialbutton.dart';
import 'package:user_appointment/presentation/widgets/auth/resetpassword/customtestformfield.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool _isPasswordVisible = false;
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String? email;
  bool _isInit = false;

  @override
  void initState() {
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      email = args['email'];
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    passwordController.dispose();
    repeatPasswordController.dispose();
    formState.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    // email = args['email'];
    print("Email ============================== $email");
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        backgroundColor: MyColors.bg,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text(
              "Please Enter New Password",
              style: smallStyle.copyWith(
                color: MyColors.header01.withOpacity(0.5),
                fontSize: 17.0,
              ),
            ),
          ),
          Form(
            key: formState,
            child: Container(
              margin: EdgeInsets.only(top: 30.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 20.0,
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
                    labelText: "Password",
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.lock_outline,
                    validator: (value) {
                      return validInput(value!, 4, 20, "password");
                    },
                    obscureText: !_isPasswordVisible,
                    controller: passwordController,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
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
                  const SizedBox(height: 20),
                  // --- Password Field ---
                  CustomTextFormField(
                    labelText: "Password",
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.lock_outline,
                    validator: (value) {
                      return validInput(value!, 4, 20, "password");
                    },
                    obscureText: !_isPasswordVisible,
                    controller: repeatPasswordController,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
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
                ],
              ),
            ),
          ),
          SizedBox(height: 30.0),
          CustomMaterialButton(
            color: MyColors.header01,
            minWidth: MediaQuery.of(context).size.width - 80,
            onPressed: () {
              if(formState.currentState!.validate()){
                if (passwordController.text != repeatPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Password does't Match ❌")),
                  );
                } else {
                  context.read<LoginCubit>().resetPassword(
                    context,
                    email!,
                    passwordController.text,
                  );
                  Navigator.of(context).pushReplacementNamed(AppRotes.login);
                }
              }
            },
            radius: 15.0,
            child: Text(
              "Reset",
              style: kTitleStyle.copyWith(color: MyColors.bg),
            ),
          ),
        ],
      ),
    );
  }
}


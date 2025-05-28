import 'dart:io';
import 'package:user_appointment/business_logic/auth/signup_cubit.dart';
import 'package:user_appointment/business_logic/auth/signup_state.dart';
import 'package:user_appointment/constants/colors.dart';
import 'package:user_appointment/constants/fileupload.dart';
import 'package:user_appointment/link_api.dart';
import 'package:user_appointment/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_appointment/presentation/screens/auth/login.dart';
import 'package:user_appointment/presentation/screens/setting/settingsdetails.dart';
import 'package:user_appointment/presentation/widgets/auth/customelevatedbutton.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;
  late TextEditingController specializationController;
  late TextEditingController experienceController;

  File? file;
  bool isType = false;
  bool isShowPassword = true;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<SignUpCubit>().getCurrentUser();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    specializationController = TextEditingController();
    experienceController = TextEditingController();
    nameController.text = "Dr ${myBox!.get("doctorName").toString()}";
    emailController.text = myBox!.get("doctorEmail").toString();
    passwordController.text = myBox!.get("doctorPassword").toString();
    phoneController.text = myBox!.get("doctorPhone").toString();
    specializationController.text = myBox!.get("specialization").toString();
    experienceController.text = myBox!.get("experience").toString();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    //twonController.dispose();
    file = null;
    super.dispose();
  }

  chooseImageGallery() async {
    file = await takePhotoWithGallery();
    setState(() {});
  }

  chooseImageCamera() async {
    file = await takePhotoWithCamera();
    setState(() {});
  }

  removeFile() {
    if (file != null) {
      file = null;
    }
    setState(() {});
  }

  chooseImageOption() {
    showAttachmentOptions(
      context,
      chooseImageGallery,
      chooseImageCamera,
      removeFile,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    // Define the light blue background color
    //final Color backgroundColor = Colors.blue[50] ?? const Color(0xFFE3F2FD);
    final Color settingsIconColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: backgroundColor, //Colors.white,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 3.0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black87, // Darker text color
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: settingsIconColor),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsDetailsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          if (state is SignUpStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SignUpStateLoaded) {
            return Form(
              key: formState,
              child: Column(
                // Use ListView for scrollability
                children: <Widget>[
                  const SizedBox(height: 30.0), // Space above profile picture
                  // Profile Picture
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        //_showImageSourceActionSheet(context);

                        chooseImageOption();
                      },

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ), // Rounded corners
                        child:
                            file != null
                                ? Image.file(
                                  file!,
                                  height: 120.0,
                                  width: 120.0,
                                  fit: BoxFit.cover,
                                )
                                : Image.network(
                                  "${AppLink.viewDoctorImage}/${cubit.getDoctorImage}",

                                  // Apply ColorFiltered for B&W effect (optional)
                                  // ignore: deprecated_member_use
                                  color: Colors.grey.withOpacity(0.5),
                                  colorBlendMode:
                                      BlendMode.saturation, // Makes it B&W
                                  height: 120.0,
                                  width: 120.0,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stacktrace) => Column(
                                        children: [
                                          Container(
                                            // Fallback
                                            height: 120.0,
                                            width: 120.0,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: Icon(
                                              Icons.person,
                                              size: 60,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0), // Space below profile picture
                  // Info Cards
                  _buildInfoCard(
                    nameController.text,
                     nameController,
                    enabled: false,
                  ),
                  _buildInfoCard(
                    emailController.text,
                    emailController,
                    enabled: false,
                  ),
                  _buildInfoCard(
                    passwordController.text,
                    passwordController,
                    obscureText: isShowPassword,
                    iconData: Icons.remove_red_eye_outlined,
                    onPressedIcon: () {
                      setState(() {
                        isShowPassword = isShowPassword == true ? false : true;
                      });
                    },
                    enabled: false,
                  ),
                  _buildInfoCard(
                    phoneController.text,
                    phoneController,
                    enabled: false,
                  ),
                  const SizedBox(height: 50.0),

                  //_buildInfoCard(twonController.text, twonController),
                  const SizedBox(
                    height: 10.0,
                  ), // Extra space at the bottom if needed
                  // Save Button
                  if (isType ||
                      file !=
                          null) // Show button if typing or image is selected
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomElevatedButton(
                        onPressed: () {
                          cubit.updateCurrentDoctor(file!);
                        },
                        width: 150,
                        backgroundColor: MyColors.header01,
                        foregroundColor: MyColors.white,
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ),

                      // ElevatedButton(
                      //   onPressed: () {
                      //     // Handle save action

                      //     cubit.updateCurrentDoctor(file!);
                      //     print("value of imageFile ===============$file");
                      //     print("Save button pressed");
                      //     setState(() {
                      //       file = null;
                      //       isShowPassword = true;
                      //       isType = false; // Reset the typing state
                      //     });

                      //     // Add your save logic here
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: MyColors.header01, // Button color
                      //     padding: const EdgeInsets.symmetric(vertical: 15.0),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //   ),
                      //   child: const Text(
                      //     'Save Changes',
                      //     style: TextStyle(fontSize: 16.0, color: Colors.white),
                      //   ),
                      // ),
                    ),

                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      margin: EdgeInsets.all(20.0),
                      child: ListTile(
                        title: const Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: MyColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: ()  {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Login()),
                              (route) => false,
                            );
                             myBox!.clear();

                          },
                          icon: const Icon(Icons.logout),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text(" Something Wrong ... "));
          }
        },
      ),
    );
  }

  Widget _buildInfoCard(
    String text,
    TextEditingController controller, {
    bool obscureText = false, // Default to false for non-password fields
    IconData? iconData,
    void Function()? onPressedIcon,
    bool? enabled,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        enabled: enabled,
        onChanged: (value) {
          if (value.isEmpty) {
            isType = false; // Check if the field is empty
          } else {
            isType = true; // Check if the field is not empty
          }
          setState(() {});
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: onPressedIcon,
            icon: Icon(iconData),
          ),
          filled: true,
          fillColor: MyColors.bg,
          hintText: controller.text,
          hintStyle: const TextStyle(color: MyColors.greyDark),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none, // No border
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18.0,
            horizontal: 15.0,
          ),
        ),
        style: const TextStyle(fontSize: 16.0, color: Colors.black87),
      ),
    );
  }
}

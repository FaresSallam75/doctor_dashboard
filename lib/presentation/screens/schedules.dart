import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:user_appointment/business_logic/appointments/appointment_cubit.dart';
import 'package:user_appointment/business_logic/appointments/appointment_state.dart';
import 'package:user_appointment/business_logic/chat/chat_cubit.dart';
import 'package:user_appointment/constants/callservices.dart';
import 'package:user_appointment/constants/colors.dart';
import 'package:user_appointment/constants/notifications.dart';
import 'package:user_appointment/constants/styles.dart';
import 'package:user_appointment/data/models/appointmentmodel.dart';
import 'package:user_appointment/main.dart';
import 'package:user_appointment/presentation/widgets/auth/customelevatedbutton.dart';

import '../../constants/showalertdialog.dart';
import '../widgets/appointments/customlistappointments.dart';

// --- The Appointment Card Widget ---

class Schedules extends StatefulWidget {
  const Schedules({super.key});

  @override
  State<Schedules> createState() => _SchedulesState();
}

class _SchedulesState extends State<Schedules> {
  CallServices callServices = CallServices();

  int selectedIndex = 0;

  List<String> appointmentsStatus = [
    "Upcoming",
    "Approved",
    "Cancelled",
    "Completed",
    // "Rating",
  ];

  @override
  void initState() {
    context.read<AppointmentCubit>().getAppointments2();
    // context.read<ChatCubit>().getUserToken(appointment.userId!);
    context.read<AppointmentCubit>().viewUserPayments();
    initAll();
    super.initState();
  }

  Future<void> initAll() async {
    // await updateDoctorLocation();
    await callServices.onUserLogin(
      myBox!.get("doctorId").toString(),
      myBox!.get("doctorName").toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 3.0,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                CustomListAppointments(
                  child: ListView.separated(
                    separatorBuilder:
                        (context, index) => const SizedBox(width: 20.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: appointmentsStatus.length,
                    itemBuilder: (context, index) {
                      return Appointments(
                        text: appointmentsStatus[index],
                        isSelected: selectedIndex == index,
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      );
                    },
                  ),
                ),

                GetAppointmentsDoctorCard(selectedIndex: selectedIndex),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GetAppointmentsDoctorCard extends StatelessWidget {
  final int selectedIndex;

  const GetAppointmentsDoctorCard({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        if (state is AppointmentStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AppointmentStateLoaded) {
          String? getUserId;
          final appointments =
              state.listAppointmentsModel.where((appointment) {
                getUserId = appointment.userId!;
                return appointment.appointmentStatus ==
                    selectedIndex.toString();
              }).toList();
          print(
            "String? getUserId ================================= $getUserId",
          );

          final now = Jiffy.parse(DateTime.now().toString()).date;

          final todayAppointments =
              appointments
                  .where((a) => Jiffy.parse(a.appointmentDate!).date == now)
                  .toList();

          final missedAppointments =
              appointments
                  .where((a) => Jiffy.parse(a.appointmentDate!).date < now)
                  .toList();

          final upcomingAppointments =
              appointments
                  .where((a) => Jiffy.parse(a.appointmentDate!).date > now)
                  .toList();


           String? paymentsUserId;
          String? paymentsdoctorId;
          context.read<AppointmentCubit>().listUserPayment.where((payments) {
            paymentsUserId = payments[0]['user_id'].toString();
            paymentsdoctorId = payments[0]['doctor_id'].toString();
            return true;
          }).toList();

          print(
            "paymentsUserId =========================== $paymentsUserId",
          );
          print(
            "paymentsdoctorId =========================== $paymentsdoctorId",
          );

          return Column(
            children: [
              if (todayAppointments.isNotEmpty) ...[
                if (selectedIndex != 2 && selectedIndex != 3)
                  _buildSectionHeader("Today", context),
                ...todayAppointments.map(
                  (a) => _buildAppointmentCard(context, a, paymentsUserId!),
                ),
              ],
              if (missedAppointments.isNotEmpty) ...[
                if (selectedIndex != 2 && selectedIndex != 3)
                  _buildSectionHeader("Missed", context),
                ...missedAppointments.map(
                  (a) => _buildAppointmentCard(context, a,paymentsUserId!),
                ),
              ],
              if (upcomingAppointments.isNotEmpty) ...[
                if (selectedIndex != 2 && selectedIndex != 3)
                  _buildSectionHeader("Upcoming", context),
                ...upcomingAppointments.map(
                  (a) => _buildAppointmentCard(context, a,paymentsUserId!),
                ),
              ],
              if (todayAppointments.isEmpty &&
                  missedAppointments.isEmpty &&
                  upcomingAppointments.isEmpty)
                const Center(child: Text('No appointments available')),
            ],
          );
        } else if (state is AppointmentStateError) {
          return Center(child: Text(state.errorMessage));
        } else {
          return const Center(
            child: Text("Check Your Internet Connection ..."),
          );
        }
      },
    );
  }

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.center,
      height: 40.0,
      width: MediaQuery.of(context).size.width - 150,
      decoration: BoxDecoration(
        color: MyColors.thirdColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAppointmentCard(
    BuildContext context,
    AppointmentModel appointment,
      String paymentUserId
  ) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: customLoadedAppointments(context, appointment , paymentUserId),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
      mainAxisSize: MainAxisSize.min, // Take minimum vertical space
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600], // Lighter grey for label
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4), // Spacing between label and value
        Text(
          value,
          style: const TextStyle(
            color: Colors.black87, // Slightly off-black for value
            fontSize: 16,
            fontWeight: FontWeight.w500, // Medium weight
          ),
        ),
      ],
    );
  }

  Widget customLoadedAppointments(
    BuildContext context,
    AppointmentModel appointment,
    String paymenUserId, 
    
    // String appointmentStatus
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space items out
          children: [
            Expanded(
              child: _buildInfoColumn(
                'Date',
                Jiffy.parse(appointment.appointmentDate!).yMMMd, //yMMMEd
              ),
            ),
            Expanded(
              child: _buildInfoColumn(
                'Time',
                Jiffy.parse(appointment.appointmentDate!).jm,
              ),
            ),
            Expanded(child: _buildInfoColumn('Patient', appointment.userName!)),
          ],
        ),

        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Divider(height: 1, thickness: 1, color: Colors.black12),
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: _buildInfoColumn('Type', appointment.specialization!),
            ),
            Expanded(
              child: _buildInfoColumn(
                'Place',
                "City Clinic",
                //'${myBox!.get('doctorLocation')}',
              ),
            ),
             //  Spacer() ,
             if(appointment.userId.toString() == paymenUserId.toString())
               Text("Paied"),
            if(appointment.userId.toString() == paymenUserId.toString())
               Icon(Icons.check_box_rounded , color: MyColors.thirdColor,)
            // const SizedBox(width: 16),
          ],
        ),
        SizedBox(height: 16.0),

        Row(
          mainAxisAlignment:
              appointment.appointmentStatus == "1"
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceAround,

          children: [
            if (appointment.appointmentStatus == "0" ||
                appointment.appointmentStatus == "1")
              CustomElevatedButton(
                backgroundColor: MyColors.thirdColor, // Colors.redAccent[400],
                foregroundColor: MyColors.white,
                width: 100,
                onPressed:
                    appointment.appointmentStatus == "0"
                        ? () {
                          context.read<AppointmentCubit>().approveAppointment(
                            appointment.userId!,
                          );
                          sendFCMMessage(
                            context,
                            "Dr. ${myBox!.get("doctorName")}",
                            "Dr. ${myBox!.get("doctorName")} Approve Yor Appointment, "
                                "Now You Can Pay Online If You Want .",
                            "fares",
                            context
                                .read<AppointmentCubit>()
                                .getUserToken(appointment.userId!)
                                .toString(),
                            "appointment",
                          );
                          print(
                            "target token ========= ${context.read<AppointmentCubit>().getUserToken(appointment.userId!).toString()}",
                          );
                        }
                        : appointment.appointmentStatus == "1"
                        ? () {
                          context.read<AppointmentCubit>().completeAppointment(
                            appointment.userId!,
                          );
                        }
                        : null,
                child: Text(
                  appointment.appointmentStatus == "0" ? "Approve" : "Complete",
                  style: smallStyle.copyWith(color: MyColors.black),
                ),
              ),

            appointment.appointmentStatus == "1" ||
                    appointment.appointmentStatus == "3"
                ? Container()
                : CustomElevatedButton(
                  backgroundColor: MyColors.thirdColor,
                  foregroundColor: MyColors.white,
                  width: 100,
                  onPressed:
                      appointment.appointmentStatus == "2"
                          ? () {
                            // To-Do
                            print("Do You want to Delete this.. ");
                          }
                          : () {
                            showAlertDialog(
                              context,
                              "Cancel",
                              "Are you sure to cancel this appointment .",
                              () {
                                context
                                    .read<AppointmentCubit>()
                                    .cancelAppointment(appointment.userId!);
                                Navigator.of(context).pop();
                                sendFCMMessage(
                                  context,
                                  "Dr. ${myBox!.get("doctorName")}",
                                  "Dr. ${myBox!.get("doctorName")} Cancel Yor Appointment ",
                                  "fares",
                                  context.read<ChatCubit>().userToken,
                                  "appointment",
                                );
                              },
                              () => Navigator.of(context).pop(),
                            );
                          },
                  child: Text(
                    //appointment.appointmentStatus == "3" ||
                    appointment.appointmentStatus == "2" ? "Delete" : "Cancel",
                    style: smallStyle.copyWith(color: MyColors.black),
                  ),
                ),
          ],
        ),
      ],
    );
  }
}

//  final filteredAppointments =
//               state.listAppointmentsModel
//                   .where(
//                     (appointment) =>
//                         appointment.appointmentStatus ==
//                         selectedIndex.toString(),
//                   )
//                   .toList();
//           return filteredAppointments.isEmpty
//               ? const Center(child: Text('No appointments available'))
//               : ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: filteredAppointments.length,
//                 itemBuilder: (context, index) {
//                   final appointment = filteredAppointments[index];
//                   return Column(
//                     children: [
//                       if (Jiffy.parse(appointment.appointmentDate!).date ==
//                               Jiffy.parse(DateTime.now().toString()).date &&
//                           appointment.appointmentStatus == "0")
//                         Container(
//                           margin: EdgeInsets.only(top: 10.0),
//                           alignment: Alignment.center,
//                           height: 40.0,
//                           width: 200.0,
//                           decoration: BoxDecoration(
//                             color: MyColors.thirdColor,
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           child: Text(textAlign: TextAlign.center, "Today"),
//                         ),

//                       if (Jiffy.parse(appointment.appointmentDate!).date <
//                               Jiffy.parse(DateTime.now().toString()).date &&
//                           appointment.appointmentStatus == "0")
//                         Container(
//                           margin: EdgeInsets.only(top: 10.0),
//                           alignment: Alignment.center,
//                           height: 40.0,
//                           width: 200.0,
//                           decoration: BoxDecoration(
//                             color: MyColors.thirdColor,
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           child: Text(textAlign: TextAlign.center, "Missed"),
//                         ),

//                       if (Jiffy.parse(appointment.appointmentDate!).date >
//                               Jiffy.parse(DateTime.now().toString()).date &&
//                           appointment.appointmentStatus == "0")
//                         Container(
//                           margin: EdgeInsets.only(top: 10.0),
//                           alignment: Alignment.center,
//                           height: 40.0,
//                           width: 200.0,
//                           decoration: BoxDecoration(
//                             color: MyColors.thirdColor,
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           child: Text(textAlign: TextAlign.center, "Upcoming"),
//                         ),

//                       Container(
//                         margin: EdgeInsets.only(
//                           top: 10.0,
//                           left: 10.0,
//                           right: 10.0,
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16.0,
//                           vertical: 12.0,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12.0),
//                           boxShadow: [
//                             BoxShadow(
//                               // ignore: deprecated_member_use
//                               color: Colors.grey.withOpacity(0.1),
//                               spreadRadius: 1,
//                               blurRadius: 5,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: customLoadedAppointments(context, appointment),
//                       ),
//                     ],
//                   );
//                 },
//               );

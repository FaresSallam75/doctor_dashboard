import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:user_appointment/constants/showalertdialog.dart';
import 'package:user_appointment/presentation/screens/chats/cardmessages.dart';
import 'package:user_appointment/presentation/screens/setting/profile.dart';
import 'package:user_appointment/presentation/screens/schedules.dart';
import 'package:flutter/material.dart';
import 'package:user_appointment/constants/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

List<Map> navigationBarItems = [
  {'icon': Icons.calendar_today, 'index': 0, "label": "Appointments"},
  {
    'icon': Icons.chat_bubble_rounded,
    'index': 1,
    "label": "Chats",
  }, //con(MyFlutterApp.chat, size: 20.0)
  //{'icon': Icons.group_rounded, 'index': 1, "label": "Doctors"}, // doctors
  // calender = appointment
  {'icon': Icons.person, 'index': 2, "label": "Profile"}, // profile
];

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void goToSchedule(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<Map> navigationBarItems = [
    //   {'icon': Icons.home, 'index': 0},
    //   {'icon': Icons.group_rounded, 'index': 1}, // doctors
    //   {'icon': Icons.calendar_today, 'index': 2}, // calender = appointment
    //   {'icon': Icons.person, 'index': 3},
    // ];

    List<Widget> screens = [
      // const HomePageScreen(),
      const Schedules(),
      const CardChatListScreen(),
      // const AvailableSpecialist(),
      // Add more screens as needed
      const ProfileScreen(),
    ];

    return OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
        ) {
          final bool connected = !connectivity.contains(ConnectivityResult.none);
          if (!connected) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // final messenger = ScaffoldMessenger.maybeOf(context);
              // if (messenger != null && mounted) {
              //   messenger.showSnackBar(
              //     const SnackBar(content: Text("No internet connection")),
              //   );
              // }
              if (mounted) {
                functionShowAlertDialog(
                  context,
                  "Connection Failed",
                  "Please Check Your Internet Connection",
                  "OK",
                  "Setting",
                      () {
                    Navigator.of(context).pop();
                  },
                      () {
                    AppSettings.openAppSettings(type: AppSettingsType.wifi);
                    Navigator.of(context).pop();
                  },
                );
              }
            });

            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.signal_wifi_off, size: 60, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No Internet Connection',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }
          return child;

        },
      child: customLoadedScreen(screens),
    );
  }

  Widget customLoadedScreen(List<Widget> screens) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: (MyColors.primary),
      //   elevation: 0,
      //   toolbarHeight: 0,
      // ),
      body: WillPopScope(
          onWillPop: (){
            showAlertDialog(context, "Watchout", "Are You Sure To Exit From App ." ,
                (){
                  exit(0);
                } ,
                (){
              Navigator.of(context).pop();
                }
            );
            return Future.value(false);
          } ,
          child: SafeArea(child: screens[_selectedIndex])),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        selectedItemColor: (MyColors.primary),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        //backgroundColor: Color(MyColors.grey01),
        items: [
          for (var navigationBarItem in navigationBarItems)
            BottomNavigationBarItem(
              activeIcon: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                height: 40.0,
                //width: 120.0,
                decoration: BoxDecoration(
                  color:
                  _selectedIndex == navigationBarItem['index']
                      ? (MyColors.header01) //blue.shade900
                      : (Colors.yellow),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        icon: Icon(
                          navigationBarItem['icon'],
                          size: 20,
                          color: Colors.white,
                        ), // Explicitly white

                        label: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(right: 0.0),
                          child: Text(
                            "${navigationBarItem['label']}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ), // Explicitly white
                        onPressed: () {
                          // Already selected, do nothing or refresh?
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor:
                          Theme.of(context).hoverColor, //hoverColor
                          padding: EdgeInsets.only(
                            right: _selectedIndex == 0 ? 7.0 : 20.0,
                            left: _selectedIndex == 0 ? 5.0 : 20.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ), // Adjust radius
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              icon: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border(
                    bottom:
                    _selectedIndex == navigationBarItem['index']
                        ? const BorderSide(color: (MyColors.bg), width: 5)
                        : BorderSide.none,
                  ),
                ),
                child: Icon(
                  navigationBarItem['icon'],
                  color:
                  _selectedIndex == navigationBarItem['index']
                      ? (MyColors.bg)
                      : (MyColors.purple01),
                ),
              ),
              label: '',
            ),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) {
          goToSchedule(value);
        },
      ),
    );
  }
}



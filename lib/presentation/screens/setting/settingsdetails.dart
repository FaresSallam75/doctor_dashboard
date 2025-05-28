import 'package:flutter/material.dart';

// Main function to run the app (for testing purposes)

class SettingsDetailsScreen extends StatefulWidget {
  const SettingsDetailsScreen({super.key});

  @override
  State<SettingsDetailsScreen> createState() => _SettingsDetailsScreenState();
}

class _SettingsDetailsScreenState extends State<SettingsDetailsScreen> {
  // State variables for the switches
  bool _notificationsEnabled = true;
  bool _messageOptionEnabled = false;
  bool _videoCallOptionEnabled = false;
  bool _callOptionEnabled = true; // Corrected spelling from 'Optionn'

  // Helper function to build the icon with background
  Widget _buildIconContainer(IconData iconData, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: backgroundColor.withOpacity(0.15), // Light background tint
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Icon(
        iconData,
        color: backgroundColor, // Icon color matches background base
        size: 24.0, // Adjust size as needed
      ),
    );
  }

  // Helper function to build each settings tile
  Widget _buildSettingsTile({
    required IconData iconData,
    required Color iconBackgroundColor,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: _buildIconContainer(iconData, iconBackgroundColor),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: Colors.blue.shade900,
        activeColor: Colors.white, // Color when switch is ON
        inactiveTrackColor: Colors.grey[500],
        inactiveThumbColor: Colors.white,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ), // Adjust padding
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Use leading property for the back button
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            size: 20.0,
          ), // iOS style back arrow
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Settings'),
        centerTitle: true, // Center the title
        // Add a subtle bottom border like in the image
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300], // Color of the divider line
            height: 1.0,
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildSettingsTile(
            iconData: Icons.notifications_none, // Using outline variant
            iconBackgroundColor: Colors.blue.shade300, //
            title: 'Notifications',
            value: _notificationsEnabled,
            onChanged: (bool newValue) {
              setState(() {
                _notificationsEnabled = newValue;
              });
            },
          ),
          _buildSettingsTile(
            iconData: Icons.chat_bubble_outline, // Using outline variant
            iconBackgroundColor: Colors.purple.shade300,
            title: 'Message Option',
            value: _messageOptionEnabled,
            onChanged: (bool newValue) {
              setState(() {
                _messageOptionEnabled = newValue;
              });
            },
          ),
          _buildSettingsTile(
            iconData: Icons.videocam_outlined, // Using outline variant
            iconBackgroundColor: Colors.purple.shade300, // Same as message icon
            title: 'Video Call Option',
            value: _videoCallOptionEnabled,
            onChanged: (bool newValue) {
              setState(() {
                _videoCallOptionEnabled = newValue;
              });
            },
          ),
          _buildSettingsTile(
            iconData: Icons.call_outlined, // Using outline variant
            iconBackgroundColor: Colors.pink.shade200, // Coral/pinkish color
            title: 'Call Option', // Corrected spelling
            value: _callOptionEnabled,
            onChanged: (bool newValue) {
              setState(() {
                _callOptionEnabled = newValue;
              });
            },
          ),
        ],
      ),
    );
  }
}

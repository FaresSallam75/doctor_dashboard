import 'package:user_appointment/constants/const.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class CallServices {
  /// on App's user login
  Future<void> onUserLogin(String doctorId, String doctorName) async {
    /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged in or re-logged in
    /// We recommend calling this method as soon as the user logs in to your app.
    await ZegoUIKitPrebuiltCallInvitationService().init(
      appID: MyConst.appId /*input your AppID*/,
      appSign: MyConst.appSign /*input your AppSign*/,

      userID: doctorId,
      userName: "Dr $doctorName",
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }

  /// on App's user logout
  Future<void> onUserLogout() async {
    /// 1.2.2. de-initialization ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged out
    await ZegoUIKitPrebuiltCallInvitationService().uninit();
  }
}

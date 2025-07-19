import 'package:flutter/cupertino.dart';
import '../../platform/platform_interface.dart';

class DashboardViewModel extends ChangeNotifier {
  bool loading = true;
  String battery = '';
  String deviceName = '';
  String osVersion = '';

  final IDeviceInfoChannel deviceInfoChannel;

  DashboardViewModel({required this.deviceInfoChannel}) {
    loadDeviceInfo();
  }

  Future<void> loadDeviceInfo() async {
    loading = true;
    notifyListeners();

    final info = await deviceInfoChannel.getDeviceInfo();
    battery = info['battery'];
    deviceName = info['device'];
    osVersion = info['os'];


    loading = false;
    print('Device Info Loaded: $battery, $deviceName, $osVersion');

    notifyListeners();
  }
}

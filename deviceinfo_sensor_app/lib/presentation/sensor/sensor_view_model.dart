
import 'package:flutter/cupertino.dart';
import '../../core/platform_channels/sensor_channel.dart';
import '../../platform/sensor_interface.dart';

class SensorViewModel extends ChangeNotifier {
  final ISensorChannel sensorChannel;

  bool flashlightOn = false;
  String gyroscope = '';

  // final SensorChannel sensorChannel;
  // SensorViewModel({required this.sensorChannel});
  SensorViewModel({required this.sensorChannel});

  Future<void> toggleFlash(bool on) async {
    await sensorChannel.toggleFlashlight(on);
    flashlightOn = on;
    notifyListeners();
  }

  // void toggleFlashlight(bool on) async {
  //   flashlightOn = on;
  //   notifyListeners();
  //   await SensorChannel.toggleFlashlight(on);
  // }

  Future<void> loadGyroscope() async {
    final data = await sensorChannel.getGyroscope();
    gyroscope = data.toString();
    notifyListeners();
  }
}

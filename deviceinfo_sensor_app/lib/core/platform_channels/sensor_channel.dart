import 'package:flutter/services.dart';

import '../../platform/sensor_interface.dart';

class SensorChannel implements ISensorChannel {
  static const MethodChannel _channel = MethodChannel('sensor.channel');
  // static const platform = MethodChannel('sensor.channel');

  @override
  Future<void> toggleFlashlight(bool on) async {
    await _channel.invokeMethod('toggleFlashlight', {'on': on});
  }
  // static Future<void> toggleFlashlight(bool on) async {
  //   await platform.invokeMethod('toggleFlashlight', {'on': on});
  // }

  @override
  Future<Map<String, dynamic>> getGyroscope() async {
    final result = await _channel.invokeMethod<Map>('getGyroscope');
    return Map<String, dynamic>.from(result ?? {});
  }
  // static Future<Map<String, dynamic>> getGyroscope() async {
  //   final result = await platform.invokeMethod<Map>('getGyroscope');
  //   return Map<String, dynamic>.from(result ?? {});
  // }
}

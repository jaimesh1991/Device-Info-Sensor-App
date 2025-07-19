import 'package:flutter/services.dart';
import '../../platform/platform_interface.dart';


class DeviceInfoChannel implements IDeviceInfoChannel {
  static const MethodChannel _channel = MethodChannel('device.info.channel');
  // static const platform = MethodChannel('device.info.channel');

  @override
  Future<Map<String, dynamic>> getDeviceInfo() async {
    final result = await _channel.invokeMethod<Map>('getDeviceInfo');
    return Map<String, dynamic>.from(result ?? {});
  }

  // static Future<Map<String, dynamic>> getDeviceInfo() async {
  //   final result = await platform.invokeMethod<Map>('getDeviceInfo');
  //   return Map<String, dynamic>.from(result ?? {});
  // }
}
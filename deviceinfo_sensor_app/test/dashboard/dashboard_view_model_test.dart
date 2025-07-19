import 'package:deviceinfo_sensor_app/platform/platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDeviceInfoChannel implements IDeviceInfoChannel {
  @override
  Future<Map<String, dynamic>> getDeviceInfo() async {
    return {
      'battery': 85,
      'deviceName': 'Pixel 5',
      'osVersion': 'Android 13',
    };
  }
}

void main() {
  group('DeviceInfoChannel Tests', () {
    test('MockDeviceInfoChannel returns correct mock data', () async {
      final IDeviceInfoChannel mockChannel = MockDeviceInfoChannel();

      final result = await mockChannel.getDeviceInfo();

      expect(result['battery'], equals(85));
      expect(result['deviceName'], equals('Pixel 5'));
      expect(result['osVersion'], equals('Android 13'));
    });
  });
}

import 'package:deviceinfo_sensor_app/platform/sensor_interface.dart';
import 'package:deviceinfo_sensor_app/presentation/sensor/sensor_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

class MockSensorChannel implements ISensorChannel {
  bool flashlightToggled = false;

  // Make the return value configurable for testing
  Map<String, dynamic> gyroscopeToReturn = {};

  @override
  Future<void> toggleFlashlight(bool on) async {
    flashlightToggled = on;
  }

  @override
  Future<Map<String, dynamic>> getGyroscope() async {
    return gyroscopeToReturn; // Return the configurable value
  }
}


void main() {
  group('SensorViewModel', () {
    late MockSensorChannel mockSensorChannel;
    late SensorViewModel viewModel;

    setUp(() {
      mockSensorChannel = MockSensorChannel();
      viewModel = SensorViewModel(sensorChannel: mockSensorChannel);
    });

    test('toggleFlashlight updates state and calls native method', () async {

      await viewModel.toggleFlash(true);

      expect(viewModel.flashlightOn, true);
      expect(mockSensorChannel.flashlightToggled, true);
    });

    test('loadGyroscope sets data', () async {
      mockSensorChannel.gyroscopeToReturn = {"x": 0.1, "y": 0.2, "z": 0.3};

      await viewModel.loadGyroscope();

      expect(viewModel.gyroscope.contains("x"), true);
      expect(viewModel.gyroscope.contains("y"), true);
      expect(viewModel.gyroscope.contains("z"), true);

      expect(viewModel.gyroscope.contains("0.1"), true);
      expect(viewModel.gyroscope.contains("0.2"), true);
      expect(viewModel.gyroscope.contains("0.3"), true);
    });
  });
}

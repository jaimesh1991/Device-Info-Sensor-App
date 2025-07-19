import 'package:deviceinfo_sensor_app/presentation/dashboard/dashboard_screen.dart';
import 'package:deviceinfo_sensor_app/presentation/dashboard/dashboard_view_model.dart';
import 'package:deviceinfo_sensor_app/presentation/sensor/sensor_screen.dart';
import 'package:deviceinfo_sensor_app/presentation/sensor/sensor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'mocks.mocks.dart';
import 'package:mockito/mockito.dart';

void main() {
  testWidgets('DashboardScreen displays mocked device info', (WidgetTester tester) async {
    // Arrange: Create a mock ViewModel
    final mockViewModel = MockDashboardViewModel();

    // Stub the values you expect the ViewModel to return
    when(mockViewModel.loading).thenReturn(false);
    when(mockViewModel.battery).thenReturn("85%");
    when(mockViewModel.deviceName).thenReturn("Pixel 6");
    when(mockViewModel.osVersion).thenReturn("Android 13");

    // Act: Build the widget tree with mocked provider
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<DashboardViewModel>.value(
          value: mockViewModel,
          child: DashboardScreen(),
        ),
      ),
    );

    // Assert: UI elements reflect mocked data
    expect(find.byKey(Key('batteryText')), findsOneWidget);
    expect(find.text('Battery: 85%'), findsOneWidget);
    expect(find.text('Device: Pixel 6'), findsOneWidget);
    expect(find.text('OS: Android 13'), findsOneWidget);
    expect(find.text('Go to Sensors'), findsOneWidget);
  });

  // testWidgets('Navigates to SensorScreen and reads gyroscope on button tap', (WidgetTester tester) async {
  //   final mockDashboardViewModel = MockDashboardViewModel();
  //   final mockSensorViewModel = MockSensorViewModel();
  //
  //   // Setup mock dashboard values
  //   when(mockDashboardViewModel.loading).thenReturn(false);
  //   when(mockDashboardViewModel.battery).thenReturn("50%");
  //   when(mockDashboardViewModel.deviceName).thenReturn("MockDevice");
  //   when(mockDashboardViewModel.osVersion).thenReturn("MockOS");
  //
  //   // Setup initial sensor values (before tapping)
  //   when(mockSensorViewModel.gyroscope).thenReturn(""); // gyroscope not yet read
  //
  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: ChangeNotifierProvider<DashboardViewModel>.value(
  //         value: mockDashboardViewModel,
  //         child: DashboardScreen(),
  //       ),
  //       routes: {
  //         '/sensor': (_) => ChangeNotifierProvider<SensorViewModel>.value(
  //           value: mockSensorViewModel,
  //           child: SensorScreen(),
  //         ),
  //       },
  //     ),
  //   );
  //
  //   // Tap to navigate
  //   await tester.tap(find.text('Go to Sensors'));
  //   await tester.pumpAndSettle();
  //
  //   // Verify initial state (gyroscope not yet shown)
  //   // expect(find.text('Gyroscope: '), findsOneWidget);
  //
  //   // Stub updated gyroscope value after readGyroscope call
  //   // when(mockSensorViewModel.gyroscope).thenReturn("X: 0.1 Y: 0.2 Z: 0.3");
  //
  //   when(mockSensorViewModel.loadGyroscope()).thenAnswer((_) async {
  //     when(mockSensorViewModel.gyroscope).thenReturn("X: 0.1 Y: 0.2 Z: 0.3");
  //     mockSensorViewModel.notifyListeners();
  //   });
  //   // when(mockSensorViewModel.loadGyroscope()).thenAnswer((_) {
  //   //   mockSensorViewModel.notifyListeners();
  //   // });
  //
  //   // Tap the Read Gyroscope button
  //   await tester.tap(find.text('Read Gyroscope'));
  //   await tester.pump(); // trigger rebuild
  //
  //   // Verify updated gyroscope value is displayed
  //   expect(find.text('Gyroscope: X: 0.1 Y: 0.2 Z: 0.3'), findsOneWidget);
  // });

}

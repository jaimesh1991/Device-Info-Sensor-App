abstract class ISensorChannel {
  Future<void> toggleFlashlight(bool on);
  Future<Map<String, dynamic>> getGyroscope();
}
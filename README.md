# Device-Info-Sensor-App

# 📱 Flutter Sensor Info App

This Flutter app demonstrates clean architecture with state management using `ChangeNotifier`, integration of device features like flashlight and gyroscope, and includes unit and widget test cases.

---

## 🚀 Features

- ✅ Toggle flashlight (hardware control)
- ✅ Read gyroscope data on button press
- ✅ Display device battery, name, and OS version
- ✅ Navigate between Dashboard and Sensor screens
- ✅ Splash screen on app start
- ✅ Smooth loading animation using Lottie
- ✅ Unit and widget test coverage for ViewModel and UI

---

## ⚙️ Dependencies

| Library | Use |
|--------|-----|
| `provider` | State management |
| `lottie` | Loading animations |
| `flutter_test` | Unit & widget testing |
| `mockito` | Mocking in unit tests |
| `battery_plus`, `device_info_plus`, `sensors_plus`, `torch_light` | Native feature integration |

---

## 🧪 Testing

### ✅ Unit Test
- Tested `SensorViewModel` using mock dependencies.
- Validated flashlight toggle, gyroscope load, and notifyListeners.




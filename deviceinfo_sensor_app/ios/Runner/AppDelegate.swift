// import Flutter
// import UIKit
//
// @main
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }

import UIKit
import Flutter
import AVFoundation
import CoreMotion

@main
@objc class AppDelegate: FlutterAppDelegate {
    let motionManager = CMMotionManager()

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

        // Device Info Channel
        let deviceChannel = FlutterMethodChannel(name: "device.info.channel", binaryMessenger: controller.binaryMessenger)
        deviceChannel.setMethodCallHandler { call, result in
            if call.method == "getDeviceInfo" {
                UIDevice.current.isBatteryMonitoringEnabled = true
                let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
                let deviceName = UIDevice.current.name
                let osVersion = UIDevice.current.systemVersion

                let info: [String: String] = [
                    "battery": "\(batteryLevel)%",
                    "device": deviceName,
                    "os": "iOS \(osVersion)"
                ]
                result(info)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        // Sensor Channel
        let sensorChannel = FlutterMethodChannel(name: "sensor.channel", binaryMessenger: controller.binaryMessenger)
        sensorChannel.setMethodCallHandler { call, result in
            switch call.method {
            case "toggleFlashlight":
                guard let args = call.arguments as? [String: Any],
                      let on = args["on"] as? Bool else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing parameter", details: nil))
                    return
                }
                self.toggleFlashlight(on: on)
                result(nil)

            case "getGyroscope":
                if self.motionManager.isGyroAvailable {
                    self.motionManager.startGyroUpdates()
                    if let gyroData = self.motionManager.gyroData {
                        let data = [
                            "x": gyroData.rotationRate.x,
                            "y": gyroData.rotationRate.y,
                            "z": gyroData.rotationRate.z
                        ]
                        result(data)
                    } else {
                        result(["x": 0, "y": 0, "z": 0])
                    }
                } else {
                    result(FlutterError(code: "UNAVAILABLE", message: "Gyroscope not available", details: nil))
                }

            default:
                result(FlutterMethodNotImplemented)
            }
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func toggleFlashlight(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
        do {
            try device.lockForConfiguration()
            device.torchMode = on ? .on : .off
            device.unlockForConfiguration()
        } catch {
            print("Torch error: \(error)")
        }
    }
}

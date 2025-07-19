//package com.example.deviceinfo_sensor_app
//
//import io.flutter.embedding.android.FlutterActivity
//
//class MainActivity : FlutterActivity()

package com.example.deviceinfo_sensor_app

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorManager
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.widget.Toast
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.hardware.camera2.CameraManager

class MainActivity: FlutterActivity() {
    private val DEVICE_INFO_CHANNEL = "device.info.channel"
    private val SENSOR_CHANNEL = "sensor.channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DEVICE_INFO_CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "getDeviceInfo") {
                val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                val batteryPct = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
                val deviceModel = Build.MODEL
                val osVersion = "Android ${Build.VERSION.RELEASE}"

                val data = mapOf(
                    "battery" to "$batteryPct%",
                    "device" to deviceModel,
                    "os" to osVersion
                )
                result.success(data)
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SENSOR_CHANNEL).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "toggleFlashlight" -> {
                    val on = call.argument<Boolean>("on") ?: false
                    toggleFlashlight(on)
                    result.success(null)
                }
                "getGyroscope" -> {
                    val sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
                    val sensor = sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE)
                    if (sensor != null) {
                        result.success(mapOf(
                            "name" to sensor.name,
                            "vendor" to sensor.vendor,
                            "version" to sensor.version
                        ))
                    } else {
                        result.error("UNAVAILABLE", "Gyroscope not available", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun toggleFlashlight(on: Boolean) {
        val cameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
        val cameraId = cameraManager.cameraIdList[0]
        try {
            cameraManager.setTorchMode(cameraId, on)
        } catch (e: Exception) {
            Toast.makeText(this, "Flashlight error: ${e.message}", Toast.LENGTH_SHORT).show()
        }
    }
}

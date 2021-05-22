package com.example.andrioid_native_example

// 안드로이드에서 제공하는 기능 사용하기위한놈 (2개)
import androidx.annotation.NonNull
import  android.os.Build
//플러터에서 프레임워크가 제공하는 기능쓰기위한놈 (3개)
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.flutter.dev/info"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        println("configureFlutterEngine에옴 ")
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call, result ->
                    if (call.method == "getDeviceInfo") {
                        val deviceInfo = getDeviceInfo()
                        result.success(deviceInfo)
                    }
                }
        }

    private fun getDeviceInfo(): String{
     println("getDeviceInfo에옴 ")
        val sb = StringBuffer()
        sb.append(Build.DEVICE + "\n")
        sb.append(Build.BRAND + "\n")
        sb.append(Build.MODEL + "\n")
        return sb.toString()
    }

}

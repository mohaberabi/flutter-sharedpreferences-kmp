import Flutter
import UIKit
import shared

@main
@objc class AppDelegate: FlutterAppDelegate {

    private let channelName = "com.mohaberabi.fluttersharedprefs.kmp"
    private var sharedPrefs: SharedPrefs?

    struct MethodNames {
        static let getString = "getString"
        static let setString = "setString"
        static let getInt = "getInt"
        static let setInt = "setInt"
        static let getBoolean = "getBoolean"
        static let setBoolean = "setBoolean"
        static let remove = "remove"
        static let clear = "clear"
        static let getStringList = "getStringList"
        static let setStringList = "setStringList"
        static let contains = "contains"
    }

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)

        methodChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard let self = self else { return }

            if self.sharedPrefs == nil {
                self.sharedPrefs = SharedPrefs()
            }

            switch call.method {
            case MethodNames.getString:
                self.handleGetString(call: call, result: result)

            case MethodNames.setString:
                self.handleSetString(call: call, result: result)

            case MethodNames.getInt:
                self.handleGetInt(call: call, result: result)

            case MethodNames.setInt:
                self.handleSetInt(call: call, result: result)

            case MethodNames.getBoolean:
                self.handleGetBoolean(call: call, result: result)

            case MethodNames.setBoolean:
                self.handleSetBoolean(call: call, result: result)

            case MethodNames.remove:
                self.handleRemove(call: call, result: result)

            case MethodNames.clear:
                self.handleClear(result: result)

            case MethodNames.getStringList:
                self.handleGetStringList(call: call, result: result)

            case MethodNames.setStringList:
                self.handleSetStringList(call: call, result: result)

            case MethodNames.contains:
                self.handleContains(call: call, result: result)

            default:
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func handleGetString(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? [String: Any], let key = args["key"] as? String {
            let value = sharedPrefs?.getString(key: key)
            result(value)
        } else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Key is required", details: nil))
        }
    }

    private func handleSetString(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? [String: Any],
           let key = args["key"] as? String,
           let value = args["value"] as? String {
            sharedPrefs?.setString(key: key, value: value)
            result(nil)
        } else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Key and value are required", details: nil))
        }
    }
    private func handleGetInt(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? [String: Any], let key = args["key"] as? String {
            let defaultValue = Int32(args["default"] as? Int ?? 0)
            let value = sharedPrefs?.getInt(key: key, default: defaultValue)
            result(value)
        } else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Key is required", details: nil))
        }
    }

    private func handleSetInt(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? [String: Any],
           let key = args["key"] as? String,
           let value = args["value"] as? Int {
            sharedPrefs?.setInt(key: key, value: Int32(value))
            result(nil)
        } else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Key and value are required", details: nil))
        }
    }


    private func handleGetBoolean(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? [String: Any], let key = args["key"] as? String {
            let defaultValue = args["default"] as? Bool ?? false
            let value = sharedPrefs?.getBoolean(key: key, default: defaultValue)
            result(value)
        } else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Key is required", details: nil))
        }
    }

    private func handleSetBoolean(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? [String: Any],
           let key = args["key"] as? String,
           let value = args["value"] as? Bool {
            sharedPrefs?.setBoolean(key: key, value: value)
            result(nil)
        } else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Key and value are required", details: nil))
        }
    }

    private func handleRemove(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? [String: Any], let key = args["key"] as? String {
            sharedPrefs?.remove(key: key)
            result(nil)
        } else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Key is required", details: nil))
        }
    }

    private func handleClear(result: @escaping FlutterResult) {
        sharedPrefs?.clear()
        result(nil)
    }

    private func handleGetStringList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? [String: Any], let key = args["key"] as? String {
            let value = sharedPrefs?.getStringList(key: key)
            result(value)
        } else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Key is required", details: nil))
        }
    }

    private func handleSetStringList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? [String: Any],
           let key = args["key"] as? String,
           let values = args["values"] as? [String] {
            sharedPrefs?.setStringList(key: key, values: values)
            result(nil)
        } else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Key and values are required", details: nil))
        }
    }

    private func handleContains(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? [String: Any], let key = args["key"] as? String {
            let exists = sharedPrefs?.contains(key: key)
            result(exists)
        } else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Key is required", details: nil))
        }
    }
}

import Flutter
import UIKit

public class SwiftMaioFlutterPlugin: NSObject, FlutterPlugin {
  private let channel: FlutterMethodChannel
  private let controller: RewardedAdController
  
  init(_ channel: FlutterMethodChannel) {
    self.channel = channel
    self.controller = RewardedAdController(channel)
  }
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "maio_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftMaioFlutterPlugin(channel)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let args = call.arguments as? [String : Any?] ?? [:]
    
    switch call.method {
    case "init":
      self.controller.initialize(args)
    case "show":
      self.controller.show(call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

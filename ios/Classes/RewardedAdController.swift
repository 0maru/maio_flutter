//
//  RewardedAdController.swift
//  maio_flutter
//
//  Created by 0maru on 2020/11/30.
//

import Foundation
import Maio

class RewardedAdController: NSObject {
  private let channel: FlutterMethodChannel
  
  init(_ channel: FlutterMethodChannel) {
    self.channel = channel
  }
  
  public func initialize(_ args: [String: Any?]) {
    let mediaId = args["mediaId"] as? String
    Maio.start(withMediaId: mediaId, delegate: self)
  }
  
  public func show(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if Maio.canShow() {
      let view = ViewController.get()
      Maio.show(with: view)
    } else {
      result(false)
    }
    result(true)
  }
}

extension RewardedAdController: MaioDelegate {
  // 広告表示準備が出来たら呼ばれる
  func maioDidInitialize() {
      channel.invokeMethod("onAdLoaded", arguments: nil)
  }

  // 広告の配信可能状態が変更された際に呼ばれる
  func maioDidChangeCanShow(_ zoneId: String?, newValue: Bool) {
      channel.invokeMethod("onCanShow", arguments: ["canShow": newValue])
  }
  
  // 広告が再生される直前に呼ばれる
  func maioWillStartAd(_ zoneId: String?) {
      channel.invokeMethod("onAdOpen", arguments: nil)
  }
  
  // 広告の再生が終了したら呼ばれる
  // skipped が false なら最後まで見ている
  func maioDidFinishAd(_ zoneId: String?,
      playtime: Int,
      skipped: Bool,
      rewardParam: String?
  ) {
      channel.invokeMethod("onAdCompleted", arguments: ["isSkipped": skipped])
  }
  
  // 広告がクリックされ外部リンクに遷移した際に呼ばれる
  func maioDidClickAd(_ zoneId: String?) {
  }
  
  // 広告が閉じられる時に呼ばれる
  func maioDidCloseAd(_ zoneId: String?) {
      channel.invokeMethod("onAdClosed", arguments: nil)
  }
  
  // SDKでエラーが生じた際に呼ばれる
  func maioDidFail(_ zoneID: String?, reason: MaioFailReason) {
      channel.invokeMethod("onAdFailedToLoad",
          arguments: ["errorCode": reason.rawValue])
  }
}

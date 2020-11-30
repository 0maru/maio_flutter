import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class MaioRewardedAd {
  MaioRewardedAd({
    this.onAdLoaded,
    this.onCanShow,
    this.onAdOpen,
    this.onAdCompleted,
    this.onAdClosed,
    this.onAdFailedToLoad,
  }) {
    _channel.setMethodCallHandler(handlerEvent);
  }

  final void Function() onAdLoaded;
  final void Function(bool canShow) onCanShow;
  final void Function() onAdOpen;
  final void Function(bool isSkipped) onAdCompleted;
  final void Function() onAdClosed;
  final void Function(int code) onAdFailedToLoad;

  static const _channel = MethodChannel('maio_flutter');

  @override
  Future<void> handlerEvent(MethodCall call) {
    switch (call.method) {
      case 'onAdLoaded':
        onAdLoaded();
        break;
      case 'onCanShow':
        //  在庫の有無を取れる
        final canShow = call.arguments['canShow'] as bool;
        onCanShow(canShow);
        break;
      case 'onAdOpen':
        SystemChrome.setEnabledSystemUIOverlays([]);
        onAdOpen();
        break;
      case 'onAdCompleted':
        final isSkipped = call.arguments['isSkipped'] as bool;
        onAdCompleted(isSkipped);
        break;
      case 'onAdClosed':
        SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        onAdClosed();
        break;
      case 'onAdFailedToLoad':
        final code = call.arguments['errorCode'] as int;
        onAdFailedToLoad(code);
        break;
    }
    return null;
  }

  static void init({@required String mediaId}) =>
      _channel.invokeMethod("init", {"mediaId": mediaId});

  static Future<bool> show() async => await _channel.invokeMethod('show', {});

  static Future<void> dispose() async => await _channel.invokeMethod('dispose', {});
}

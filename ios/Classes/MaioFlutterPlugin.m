#import "MaioFlutterPlugin.h"
#if __has_include(<maio_flutter/maio_flutter-Swift.h>)
#import <maio_flutter/maio_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "maio_flutter-Swift.h"
#endif

@implementation MaioFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMaioFlutterPlugin registerWithRegistrar:registrar];
}
@end

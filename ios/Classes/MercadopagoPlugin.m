#import "MercadopagoPlugin.h"
#if __has_include(<mercadopago/mercadopago-Swift.h>)
#import <mercadopago/mercadopago-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mercadopago-Swift.h"
#endif

@implementation MercadopagoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMercadopagoPlugin registerWithRegistrar:registrar];
}
@end

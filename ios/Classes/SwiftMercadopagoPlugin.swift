import Flutter
import UIKit
import MercadoPagoSDK

public class SwiftMercadopagoPlugin: NSObject, FlutterPlugin, PXLifeCycleProtocol {
       
    var flutterResult: FlutterResult? = nil
    var delegateWindow : UIWindow
    
    init(delegateWindow: UIWindow){
        self.delegateWindow = delegateWindow
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let messenger = registrar.messenger()
    let channel = FlutterMethodChannel(name: "mercadopago", binaryMessenger: messenger)

    let delegateWindow = UIApplication.shared.delegate!.window!!
    let instance = SwiftMercadopagoPlugin(delegateWindow: delegateWindow)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    if(call.method == "startPayment"){
        startPayment(result, call)
    }
  }
 
    func startPayment(_ result: @escaping FlutterResult, _ call: FlutterMethodCall) {
        self.flutterResult = result
        let arguments = call.arguments as! NSDictionary
        let publicKey = arguments["publicKey"] as! String
        let checkoutPreferenceId = arguments["checkoutPreferenceId"] as! String
        if(UIApplication.shared.keyWindow!.rootViewController! is UINavigationController){
            openMercadoPagoCheckout(publicKey, checkoutPreferenceId, UIApplication.shared.keyWindow!.rootViewController! as! UINavigationController)
        }else{
            result("Check the documentation and implement the UINavigationController on Runner.AppDelegate");
        }
    }

     public func cancelCheckout() -> (() -> Void)? {
         self.flutterResult!("cancelCheckout")
         return nil
     }
     
     public func finishCheckout() -> ((PXResult?) -> Void)? {
         self.flutterResult!("finishCheckout")
         return nil
     }
    
    fileprivate func openMercadoPagoCheckout(_ publicKey: String, _ checkoutPreferenceId: String, _ navigationController: UINavigationController) {
          MercadoPagoCheckout.init(
              builder: MercadoPagoCheckoutBuilder
                  .init(
                      publicKey: publicKey,
                      preferenceId: checkoutPreferenceId))
              .start(
                  navigationController: navigationController,
                  lifeCycleProtocol: self)
      }
}

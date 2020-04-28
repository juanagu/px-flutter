import Flutter
import UIKit
import MercadoPagoSDK

public class SwiftMercadopagoPlugin: NSObject, FlutterPlugin, PXLifeCycleProtocol {
       
  var flutterResult: FlutterResult? = nil
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let messenger = registrar.messenger()
    let channel = FlutterMethodChannel(name: "mercadopago", binaryMessenger: messenger)
    let instance = SwiftMercadopagoPlugin()
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
        
        let navigationController = findNavigationController()
        openMercadoPagoCheckout(publicKey, checkoutPreferenceId, navigationController)
            
        result("execute" + publicKey + checkoutPreferenceId);
    }

     public func cancelCheckout() -> (() -> Void)? {
         self.flutterResult!("cancelCheckout")
         return nil
     }
     
     public func finishCheckout() -> ((PXResult?) -> Void)? {
         self.flutterResult!("finishCheckout")
         return nil
     }
    
    fileprivate func findNavigationController() -> UINavigationController {
        /*let delegate = UIApplication.shared.delegate
        let delegateWindow = delegate!.window!
        let rootController = (delegateWindow!.rootViewController)!
        return rootController.navigationController!*/
        let windows = UIApplication.shared.windows.filter( { (w) -> Bool in
            (w.rootViewController != nil && w.rootViewController?.navigationController != nil)
            })
        
        return windows.last!.rootViewController!.navigationController!
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

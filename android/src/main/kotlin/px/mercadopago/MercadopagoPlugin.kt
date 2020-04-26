package px.mercadopago

import com.mercadopago.android.px.core.MercadoPagoCheckout
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** MercadopagoPlugin */
class MercadopagoPlugin : MethodCallHandler {

    private lateinit var delegate: MercadoPagoDelegate

    companion object {
        const val MERCADO_PAGO_REQUEST_CODE = 7717

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "mercadopago")
            val plugin = MercadopagoPlugin()
            plugin.delegate = MercadoPagoDelegate(registrar)
            channel.setMethodCallHandler(plugin)
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "startPayment") {
            startPayment(call, result)
        } else {
            result.notImplemented()
        }
    }

    private fun startPayment(call: MethodCall, result: Result) {
        this.delegate.result = result
        var publicKey: String = call.argument("publicKey")!!
        var checkoutPreferenceId: String = call.argument("checkoutPreferenceId")!!
        MercadoPagoCheckout.Builder(
                publicKey,
                checkoutPreferenceId)
                .build()
                .startPayment(delegate.getActivity(), MERCADO_PAGO_REQUEST_CODE)
    }
}

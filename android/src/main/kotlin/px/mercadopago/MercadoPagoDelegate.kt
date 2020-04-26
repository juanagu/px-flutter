package px.mercadopago

import android.app.Activity
import android.content.Intent
import com.mercadopago.android.px.core.MercadoPagoCheckout
import com.mercadopago.android.px.model.Payment
import com.mercadopago.android.px.model.exceptions.MercadoPagoError
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class MercadoPagoDelegate : PluginRegistry.ActivityResultListener {

    constructor(registrar: PluginRegistry.Registrar) {
        this.registrar = registrar
        registrar.addActivityResultListener(this);
    }

    private var registrar: PluginRegistry.Registrar
    var result: MethodChannel.Result? = null

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == MercadopagoPlugin.MERCADO_PAGO_REQUEST_CODE) {
            onMercadoPagoResult(resultCode, data)
        }
        return false
    }

    fun getActivity(): Activity {
        return registrar.activity()
    }

    private fun onMercadoPagoResult(resultCode: Int, data: Intent?) {
        var response = HashMap<String, Any>()
        response["resultCode"] = "$resultCode"
        if (isSuccessResult(resultCode)) {
            response["payment"] = getPaymentFromData(data)
        } else if (isErrorResult(resultCode, data)) {
            response["error"] = getErrorFromData(data)
        }

        this.result?.success(JsonHelper.toJson(response))
    }

    private fun isErrorResult(resultCode: Int, data: Intent?) =
            resultCode == Activity.RESULT_CANCELED && data != null && data.extras != null

    private fun isSuccessResult(resultCode: Int) =
            resultCode == MercadoPagoCheckout.PAYMENT_RESULT_CODE

    private fun getPaymentFromData(data: Intent?): Payment {
        return data!!.getSerializableExtra(MercadoPagoCheckout.EXTRA_PAYMENT_RESULT) as Payment
    }

    private fun getErrorFromData(data: Intent?): MercadoPagoError {
        return data!!.getSerializableExtra(MercadoPagoCheckout.EXTRA_ERROR) as MercadoPagoError
    }
}
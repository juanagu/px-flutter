package px.mercadopago

import com.google.gson.Gson

class JsonHelper {
    companion object {
        fun toJson(src: Any): String {
            return Gson().toJson(src)
        }
    }
}
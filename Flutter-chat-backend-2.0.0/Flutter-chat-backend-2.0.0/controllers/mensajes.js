
const Mensaje = require('../models/mensaje');
const { cleanText } = require('../helpers/text-processing/text-cleaner');

const obtenerChat = async(req, res) => {

    const miId = req.uid;
    const mensajesDe = req.params.de;

    const last30 = await Mensaje.find({
        $or: [{ de: miId, para: mensajesDe }, { de: mensajesDe, para: miId } ]
    })
    .sort({ createdAt: 'desc' })
    .limit(30);

    // -------------

    // const mensajeLimpio = last30.map((mensaje) => ({
    //     ...mensaje.toOb
    // }));

    // -------------

    res.json({
        ok: true,
        mensajes: last30
    })

}



module.exports = {
    obtenerChat
}
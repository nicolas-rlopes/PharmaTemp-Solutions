var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idSensor", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idSensor", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
});
router.post("/pegarAlertas", function (req, res) {
    medidaController.pegarAlertas(req, res);
});
router.get("/graficoGeladeira/:idGeladeira", function (req, res) {
    medidaController.graficoGeladeira(req, res);
});
router.get("/quantidadeGeladeiras", function (req, res) {
    medidaController.quantidadeGeladeiras(req, res);
});


module.exports = router;

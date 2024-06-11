var database = require("../database/config");

function buscarUltimasMedidas(idSensor) {
    var instrucaoSql = `SELECT 
        temperatura, 
        dtHora as momento,
    DATE_FORMAT(dtHora, '%H:%i:%s') as momento_grafico
    FROM medida
    WHERE fkSensor = ${idSensor}
    ORDER BY idDado DESC 
    LIMIT  7`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idSensor) {
    var instrucaoSql = `SELECT 
        temperatura, 
        dtHora as momento,
        DATE_FORMAT(dtHora, '%H:%i:%s') as momento_grafico
    FROM medida
    WHERE fkSensor = ${idSensor}
    ORDER BY idDado DESC
    LIMIT 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
};

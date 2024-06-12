var medidaModel = require("../models/medidaModel");


function buscarUltima(req, res) {
    var idGeladeira = req.params.idGeladeira;

    if (idGeladeira == undefined) {
        res.status(400).send("ID geladeira inválido!");
    } else {

        medidaModel.buscarUltima(idGeladeira)
        .then(function (resultado) {
            res.json(resultado)
        }).catch(function () {
            res.status(500).json(erro.sqlMessage)
        })

    }

}

function graficoGeladeira(req, res) {
    var idGeladeira = req.params.idGeladeira;

    medidaModel.graficoGeladeira(idGeladeira)
      .then(
        function (resultado) {
          res.json(resultado);
        }
      ).catch(
        function (erro) {
          console.log(erro);
          console.log(
            "\nErro ao Exibir o Grafico Loja1! Erro:",
            erro.sqlMessage
          );
          res.status(500).json(erro.sqlMessage);
        }
      )
  }

function quantidadeGeladeiras(req, res) {
medidaModel
    .quantidadeGeladeiras()
    .then((data) => {
    if (data && data.length > 0) {
        console.log("Geladeira obtida com sucesso:", data);
        res.json(data);
    } else {
        res.status(404).json({ error: "ERRO Geladeira não encontrada" });
    }
    })
    .catch((error) => {
    console.error("Erro ao obter Geladeira:", error);
    res.status(500).json({ error: "Erro ao obter Geladeira:" });
    });
}

function buscarUltimasMedidas(req, res) {
    var idSensor = req.params.idSensor;
    var limite_linhas = 7;

    console.log(`Recuperando as ultimas ${limite_linhas} medidas do sensor ${idSensor}`);

    medidaModel.buscarUltimasMedidas(idSensor, limite_linhas).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!");
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as últimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function buscarMedidasEmTempoReal(req, res) {
    var idSensor = req.params.idSensor;

    console.log(`Recuperando medidas em tempo real do sensor ${idSensor}`);

    medidaModel.buscarMedidasEmTempoReal(idSensor).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!");
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as medidas em tempo real.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function pegarAlertas(req, res) {
    var email = req.body.email;

    medidaModel.pegarAlertas(email).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!");
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as medidas em tempo real.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    buscarUltima,
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    pegarAlertas,
    graficoGeladeira,
    quantidadeGeladeiras
};

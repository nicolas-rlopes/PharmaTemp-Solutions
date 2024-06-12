var alertas = [];

function obterdados(idSensor) {
    fetch(`/medidas/tempo-real/${idSensor}`)
        .then(resposta => {
            if (resposta.status == 200) {
                resposta.json().then(resposta => {

                    console.log(`Dados recebidos: ${JSON.stringify(resposta)}`);

                    alertar(resposta, idSensor);
                });
            } else {
                console.error(`Nenhum dado encontrado para o id ${idSensor} ou erro na API`);
            }
        })
        .catch(function (error) {
            console.error(`Erro na obtenção dos dados do sensor ${idSensor}: ${error.message}`);
        });

}

function alertar(resposta, idSensor) {
    var temp = resposta[0].temperatura;

    var grauDeAviso = '';

    var limites = {
        muito_quente: 11,
        quente: 9,
        ideal: 5,
        frio: 1,
        muito_frio: -2
    };

    var classe_temperatura = 'cor-alerta';

    if (temp >= limites.muito_quente) {
        classe_temperatura = 'cor-alerta perigo-quente';
        grauDeAviso = 'perigo quente'
    }
    else if (temp < limites.muito_quente && temp >= limites.quente) {
        classe_temperatura = 'cor-alerta alerta-quente';
        grauDeAviso = 'alerta quente'
    } else if (temp <= limites.frio && temp > limites.muito_frio) {
        classe_temperatura = 'cor-alerta alerta-frio';
        grauDeAviso = 'alerta frio'
    }
    else if (temp <= limites.muito_frio) {
        classe_temperatura = 'cor-alerta perigo-frio';
        grauDeAviso = 'perigo frio'
    }

    var card;

    if (document.getElementById(`temp_aquario_${idSensor}`) != null) {
        document.getElementById(`temp_aquario_${idSensor}`).innerHTML = temp + "°C";
    }

    if (document.getElementById(`card_${idSensor}`)) {
        card = document.getElementById(`card_${idSensor}`);
        card.className = `mensagem-alarme ${classe_temperatura}`;
    }

    exibirAlerta(temp, idSensor, grauDeAviso, classe_temperatura);
}

function exibirAlerta(temp, idSensor, grauDeAviso, classe_temperatura) {
    var indice = alertas.findIndex(item => item.idSensor == idSensor);

    if (indice >= 0) {
        alertas[indice] = { idSensor, temp, grauDeAviso, classe_temperatura };
    } else {
        alertas.push({ idSensor, temp, grauDeAviso, classe_temperatura });
    }

    exibirCards();
}

function removerAlerta(idSensor) {
    alertas = alertas.filter(item => item.idSensor != idSensor);
    exibirCards();
}

function exibirCards() {
    var alerta = document.getElementById('alerta');
    alerta.innerHTML = '';

    alertas.forEach(mensagem => {
        alerta.innerHTML += transformarEmDiv(mensagem);
    });
}

function transformarEmDiv({ idSensor, temp, grauDeAviso, classe_temperatura }) {
    return `
        <div id="card_${idSensor}" class="mensagem-alarme ${classe_temperatura}">
            <div class="informacao">
                <div class="${classe_temperatura}">&#12644;</div> 
                <h3>Estado de ${grauDeAviso}!</h3>
                <small>Temperatura capturada: ${temp}°C.</small>   
            </div>
            <div class="alarme-sino" onclick="removerAlerta(${idSensor})">&#128276;</div>
        </div>
    `;
}

function atualizacaoPeriodica() {
    JSON.parse(sessionStorage.SENSOR).forEach(item => {
        obterdados(item.id);
    });
    setTimeout(atualizacaoPeriodica, 5000);
}

// Iniciar a atualização periódica dos dados
atualizacaoPeriodica();

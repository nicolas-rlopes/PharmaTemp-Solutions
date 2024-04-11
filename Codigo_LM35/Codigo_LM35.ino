int pinoSensor = 0;
int valorLido = 0;
float temperatura = 0;
//bloco de variavel

void setup(){
  Serial.begin(9600);
}

void loop(){
  valorLido = analogRead(pinoSensor);
  temperatura = (valorLido * 0.00488);
  temperatura = (temperatura * 100 + 5) - 30;

  Serial.println(temperatura);


  delay(1000);
}

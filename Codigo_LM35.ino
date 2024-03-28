int pinoSensor = 0;
int valorLido = 0;
int maximo = 34;
int minimo = 29;
float temperatura = 0;
//bloco de variavel

void setup(){
  Serial.begin(9600);
}

void loop(){
  valorLido = analogRead(pinoSensor);
  temperatura = (valorLido * 0.00488);
  temperatura = temperatura * 100 + 5;

  Serial.print(temperatura);
  Serial.print(",");
  Serial.print(minimo);
  Serial.print(",");
  Serial.println(maximo);

  delay(100);
}

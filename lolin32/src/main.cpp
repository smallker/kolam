#include "firebase.h"
#define WIFI_SSID "bolt"
#define WIFI_PASSWORD "11111111"

void setup()
{
  Serial.begin(115200);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.println("\nSTART");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(500);
  }
  Serial.println("\nConnected, IP : " + WiFi.localIP().toString());
}

void loop()
{
  timeClient.update();
  StaticJsonDocument<200> history;
  char historyBuffer[200];

  /*
    Data dummy
  */
  int temperature = 30 + (rand() % 10);
  float ph = rand()%10 + 0.1;
  int flow = rand()%100 +100;

  history["temperature"] = (String)temperature;
  history["ph"] = (String)ph;
  history["flow"] = (String)flow;
  history["timestamp"] = (String)timeClient.getEpochTime();

  serializeJson(history, historyBuffer);
  sendHistoryData(historyBuffer);
  delay(5000);
}
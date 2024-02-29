#include <WiFi.h>
#include <FirebaseESP32.h>
#include <VNH3SP30.h>
//#include <driver/ledc.h>
//#include "RTClib.h"
#include <cctype>
//RTC_DS3231 rtc;
#include "time.h"

#define FIREBASE_HOST "farmer-d42ef-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "JBKHLPr4IWDTxBqV6eFGAYjCMcJvJinJk4c7kHK3"
#define WIFI_SSID "Z40" ///  The King BOB
#define WIFI_PASS "Symphony22" ///  TheKingBOB69

FirebaseData fbdo;
FirebaseData fbdo1;
FirebaseJson json;


String weather="";
int weather_chance;
time_t now;
struct tm *gm_time;
int user_enter_time;
String user_entry;


VNH3SP30 motor(13, 2, 0, 12);
int soilMoistureSensor1 = 34;//left side
int soilMoistureSensor2 = 35;//right side
int soilMoistureValue1 = 0;
int soilMoistureValue2 = 0;
double current1=0;
double current2=0;

int flowsensorpin=27;
volatile long pulse;
float flowRate = 0.0;
float calibrationFactor = 7.5;

const int relayPin1 = 23;//right side
const int relayPin2 = 22;///left side
const int MAX_PLANTS = 63;

String plantNames[MAX_PLANTS];
int waterLevels[MAX_PLANTS];
int plantTimes[MAX_PLANTS];
int numPlants = 0;

String plant1="";
String plant2="";
String plantdate1="";
String plantdate2="";

const char* ntpServer = "pool.ntp.org";
const long  gmtOffset_sec = 0;
const int   daylightOffset_sec = 3600;


int age1;//left
int age2;//right
int flag=0;


void setup() {
  motor.pinsetup();
  pinMode(relayPin1, OUTPUT);
  pinMode(relayPin2, OUTPUT);
  pinMode(flowsensorpin, INPUT);
  attachInterrupt(digitalPinToInterrupt(flowsensorpin),increase, RISING);

  Serial.begin(115200);
  delay(1000);
  WiFi.begin(WIFI_SSID, WIFI_PASS);
  Serial.print("Connecting to ");
  Serial.println(WIFI_SSID);

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }

  Serial.println("Connected to Wi-Fi!");

  // Connect to Firebase
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);


  configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);
  

  addPlant("rice", 400, 21);
  addPlant("rice", 300, 56);
  addPlant("rice", 600, 84);

  addPlant("wheat", 600, 14);
  addPlant("wheat", 400, 42);
  addPlant("wheat", 300, 84);

  addPlant("mango", 600, 0);
  addPlant("mango", 700, 0);
  addPlant("mango", 500, 0);

  addPlant("tomato", 700, 0);
  addPlant("tomato", 600, 15);
  addPlant("tomato", 600, 29);

  addPlant("potato", 800, 0);
  addPlant("potato", 700, 29);
  addPlant("potato", 1024, 57);

  addPlant("papaya", 800, 0);
  addPlant("papaya", 600, 57);
  addPlant("papaya", 1024, 141);

  addPlant("brinjal", 800, 0);
  addPlant("brinjal", 700, 15);
  addPlant("brinjal", 700, 43);

  addPlant("culiflower", 800, 0);
  addPlant("culiflower", 700, 22);
  addPlant("culiflower", 1024, 71);

  addPlant("onion", 900, 0);
  addPlant("onion", 800, 22);
  addPlant("onion", 600, 43);

  addPlant("lettuce", 800, 0);
  addPlant("lettuce", 600, 15);
  addPlant("lettuce", 1024, 57);

  addPlant("cabbage", 600, 0);
  addPlant("cabbage", 700, 15);
  addPlant("cabbage", 1024, 71);

  addPlant("bean", 800, 0);
  addPlant("bean", 600, 15);
  addPlant("bean", 1024, 57);

  addPlant("green pea", 800, 0);
  addPlant("green pea", 500, 15);
  addPlant("green pea", 400, 43);

  addPlant("spinach", 700, 0);
  addPlant("spinach", 500, 15);
  addPlant("spinach", 1024, 43);

  addPlant("sunflower", 800, 0);
  addPlant("sunflower", 600, 15);
  addPlant("sunflower", 500, 57);

  addPlant("barley", 800, 0);
  addPlant("barley", 500, 15);
  addPlant("barley", 300, 43);

  addPlant("lentil", 800, 0);
  addPlant("lentil", 600, 15);
  addPlant("lentil", 500, 43);

  addPlant("soybean", 700, 0);
  addPlant("soybean", 500, 15);
  addPlant("soybean", 400, 43);

  addPlant("maize", 700, 0);
  addPlant("maize", 500, 15);
  addPlant("maize", 400, 43);

  addPlant("sesame", 700, 0);
  addPlant("sesame", 500, 15);
  addPlant("sesame", 400, 43);

  addPlant("linseed", 700, 0);
  addPlant("linseed", 600, 15);
  addPlant("linseed", 400, 43);
}


void loop() {


  
    now = time(NULL);
    gm_time= gmtime(&now);
    user_enter_time=gm_time->tm_hour;
    user_entry = "13";
    user_entry= user_entry+ ":00";

    String path = "/Weather/" + user_entry + "/Chance";
    //Serial.println(path);

    if (Firebase.getString(fbdo, path)) {
    if (fbdo.dataTypeEnum() == fb_esp_rtdb_data_type_string) {
      weather=fbdo.to<String>();
      Serial.println(weather);
    }
    } else {
    Serial.println(fbdo.errorReason());
    }
    weather.replace("%","");
    int weather_chance=weather.toInt();
    Serial.println(weather_chance);




  if(flag==0)
  {
    digitalWrite(relayPin2, HIGH);
    digitalWrite(relayPin1, HIGH);
    Serial.println("both relay off");
    flag=1;
  }
  

  /////field 1
  //////Field1 plant name fetch
  if (Firebase.getString(fbdo, "/fieldwater/sayedulabrar14045/field1/fieldName/plant")) {
    if (fbdo.dataTypeEnum() == fb_esp_rtdb_data_type_string) {
      plant1=fbdo.to<String>();
      plant1.toLowerCase();
      Serial.println(plant1);
    }
  } else {
  Serial.println(fbdo.errorReason());
  }

  Firebase.getDouble(fbdo, "/fieldwater/sayedulabrar14045/field1/fieldName/plantdate") ;
  current1=fbdo.to<double>();

  time_t now1 = time(NULL);
  age1=(now1-current1)/86400;
  Serial.print("plant1 age: ");
  Serial.println(age1);


  int requiredMoistureLevel1 = getRequiredMoistureLevel(plant1,age1);///moisture level of field 1
  Serial.println(requiredMoistureLevel1);

  if (Firebase.getString(fbdo, "/fieldwater/sayedulabrar14045/field1/fieldName/plantdate")) {
    if (fbdo.dataTypeEnum() == fb_esp_rtdb_data_type_string) {
      plantdate1=fbdo.to<String>();
      plant1.toLowerCase();
      Serial.println(plantdate1);
    }
  } else {
  Serial.println(fbdo.errorReason());
  }

///// field 1 Soil moisture level measure
  soilMoistureValue1 = analogRead(soilMoistureSensor1);
  int moisturePercentage1 = map(soilMoistureValue1, 0, 4095, 0, 1024);
  int sensorValue1 = moisturePercentage1;
  Serial.print("Sensor value 1: ");
  Serial.println(sensorValue1);
  // Serial.print("requiredMoistureLevel1 1: ");
  // Serial.println(requiredMoistureLevel1);
  Firebase.setString(fbdo, "/fieldwater/sayedulabrar14045/field1/fieldinfo/sensor1", sensorValue1);

  if (fbdo.dataAvailable()) {
    Serial.println("Data sent to Firebase!");
  } else {
    Serial.println("Error sending data to Firebase");
    Serial.println(fbdo.errorReason());
  }








  ////field 2
  ////// ////// Field2 plant name fetch

  if (Firebase.getString(fbdo, "/fieldwater/sayedulabrar14045/field2/fieldName/plant")) {
    if (fbdo.dataTypeEnum() == fb_esp_rtdb_data_type_string) {
      plant2=fbdo.to<String>();
      plant2.toLowerCase();
      Serial.println(plant2);
    }
  } else {
    Serial.println(fbdo.errorReason());
  }

  ////// plant age
  Firebase.getDouble(fbdo, "/fieldwater/sayedulabrar14045/field2/fieldName/plantdate") ;
  current2=fbdo.to<double>();

  time_t now2 = time(NULL);
  age2=(now2-current2)/86400;
  Serial.print("plant2 age: ");
  Serial.println(age2);




  int requiredMoistureLevel2 = getRequiredMoistureLevel(plant2, age2);///soil moisture level of field 2
  Serial.println(requiredMoistureLevel2);

  if (Firebase.getString(fbdo, "/fieldwater/sayedulabrar14045/field2/fieldName/plantdate")) {
    if (fbdo.dataTypeEnum() == fb_esp_rtdb_data_type_string) {
      plantdate2=fbdo.to<String>();
      plant1.toLowerCase();
      Serial.println(plantdate2);
    }
  } else {
  Serial.println(fbdo.errorReason());
  }
  
  ///////////////---------Field 2 soil sensor level measure
  soilMoistureValue2 = analogRead(soilMoistureSensor2);
  int moisturePercentage2 = map(soilMoistureValue2, 0, 4095, 0, 1024);
  int sensorValue2 = moisturePercentage2;

  Serial.print("Sensor value 2: ");
  Serial.println(sensorValue2);
  // Serial.print("requiredMoistureLevel2 2: ");
  // Serial.println(requiredMoistureLevel2);
  Firebase.setString(fbdo, "/fieldwater/sayedulabrar14045/field2/fieldinfo/sensor2", sensorValue2);


  if (fbdo.dataAvailable()) {
    Serial.println("Data sent to Firebase!");
  } else {
    Serial.println("Error sending data to Firebase");
    Serial.println(fbdo.errorReason());
  }






  if((sensorValue2 > requiredMoistureLevel2 || sensorValue1> requiredMoistureLevel1 ) && weather_chance < 80 )
  {
      if(sensorValue1> requiredMoistureLevel1 )
      {
        digitalWrite(relayPin2, LOW); 
        Serial.println("relayPin1 LOw");
        Firebase.setString(fbdo, "/fieldwater/sayedulabrar14045/field1/fieldinfo/pump", "ON");
      }
      else
      {
        digitalWrite(relayPin2, HIGH); 
        Serial.println("relayPin1 HIGH");
        Firebase.setString(fbdo, "/fieldwater/sayedulabrar14045/field1/fieldinfo/pump", "OFF");
      }
      if(sensorValue2 > requiredMoistureLevel2 )
      {
        digitalWrite(relayPin1, LOW); 
        Serial.println("relayPin2 LOw");
        Firebase.setString(fbdo, "/fieldwater/sayedulabrar14045/field2/fieldinfo/pump", "ON");
      }
      else
      {
        digitalWrite(relayPin1, HIGH); 
        Serial.println("relayPin2 HIGH");
        Firebase.setString(fbdo, "/fieldwater/sayedulabrar14045/field2/fieldinfo/pump", "OFF");
      }

      motor.forward(100);
      Serial.println("pump on");
  }
  else
  {
      motor.forward(0);
      Serial.println("relayPin1 HIGH");
      Serial.println("relayPin2 HIGH");
      Serial.println("pump off");
      Firebase.setString(fbdo, "/fieldwater/sayedulabrar14045/field1/fieldinfo/pump", "OFF");
      Firebase.setString(fbdo, "/fieldwater/sayedulabrar14045/field2/fieldinfo/pump", "OFF");
  }



  // double fetch  fobo declared on top global
  // Firebase.getDouble(fbdo, "/fieldwater/sayedulabrar14045/field1/fieldName/plantdate") ;
  // current=fbdo.to<double>();

  // time_t now = time(NULL);
  // age=(now-current)/86400;
  // Serial.println(age);

  // Serial.println();
  Serial.println();
  Serial.println();

}

void increase(){
  pulse++;
}
void addPlant(String name, int waterLevel, int plantTime) {
  if (numPlants < MAX_PLANTS) {
    plantNames[numPlants] = name;
    waterLevels[numPlants] = waterLevel;
    plantTimes[numPlants] = plantTime;
    numPlants++;
  } else {
    Serial.println("Maximum number of plants reached!");
  }
}

int getRequiredMoistureLevel(String plantName, int age) {
  for (int i = 0; i < numPlants; i=i+3) {
    if (plantNames[i] == plantName) {
      int j=i;

      if(age>=0 && age<plantTimes[i+1])
      return waterLevels[i];

      else if(age>=plantTimes[i+1]&& age<plantTimes[i+2])
      return waterLevels[i+1];

      else
      return waterLevels[i+2];
    }
  }
  return 0; // Return 0 if the plant name is not found
}

void toLowerCase(std::string& str) {
  for (char& c : str) {
    c = std::tolower(c);
  }
}
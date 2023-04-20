#include <LedControl.h>
#include <SoftwareSerial.h>

int DIN = 10;
int CS = 9;
int CLK = 8;
int rxPin = 2; // Set to your desired RX pin
int txPin = 3; // Set to your desired TX pin

LedControl lc = LedControl(DIN, CLK, CS, 0);
SoftwareSerial mySerial(rxPin, txPin); // RX, TX

bool isAnimating = false;

void setup() {
  lc.shutdown(0, false);
  lc.setIntensity(0, 15);
  lc.clearDisplay(0);

  mySerial.begin(9600);
}

void loop() {
  if (mySerial.available() > 0) {
    String command = mySerial.readString();

    if (command.startsWith("START")) {
      isAnimating = true;
    } else if (command.startsWith("STOP")) {
      isAnimating = false;
      lc.clearDisplay(0);
    }
  }

  if (isAnimating) {
    displayAnimation();
  } else {
    displaySmile();
  }
}

void displayAnimation() {
  byte smile[8] = {0x3c, 0x42, 0x95, 0xa1, 0xa1, 0x95, 0x42, 0x3c};
  byte happy[8] = {0x3c, 0x42, 0x95, 0xb1, 0xb1, 0x95, 0x42, 0x3c};

  printByte(smile);
  delay(500);
  printByte(happy);
  delay(500);
}

void displaySmile() {
  byte smile[8] = {0x3c, 0x42, 0x95, 0xa1, 0xa1, 0x95, 0x42, 0x3c};

  printByte(smile);
}

void printByte(byte character[]) {
  int i = 0;
  for (i = 0; i < 8; i++) {
    lc.setRow(0, i, character[i]);
  }
}

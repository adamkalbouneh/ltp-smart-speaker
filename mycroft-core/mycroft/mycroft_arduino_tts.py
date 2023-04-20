import serial
from mycroft_bus_client import MessageBusClient, Message

# Configure the Arduino serial port
arduino_port = 'COM3'  # Adjust this to your Arduino's serial port
baud_rate = 9600

# Initialize the serial connection
arduino_serial = serial.Serial(arduino_port, baud_rate)
time.sleep(2)  # Allow the Arduino to initialize

def on_speak(message):
    # Send start command to the Arduino
    arduino_serial.write(b"START\n")
    arduino_serial.flush()

    # Print the spoken text to the console
    print('Mycroft is speaking:', message.data['utterance'])

    # Wait for the speaking to finish
    while arduino_serial.in_waiting == 0:
        pass

    # Send stop command to the Arduino
    arduino_serial.write(b"STOP\n")
    arduino_serial.flush()

# Connect to the Mycroft Message Bus
bus = MessageBusClient()
bus.on('speak', on_speak)
bus.run_in_thread()

import serial
import sys
import os

END_SEQUENCE = b"<<EOF>>"  # Unique marker to signal end of transmission

def receive_file(port, filename, baudrate=9600):
    print(f"[INFO] Opening serial port {port} at {baudrate} baud...")
    try:
        with serial.Serial(port, baudrate, timeout=1) as ser, open(filename, "wb") as f:
            print(f"[INFO] Receiving data. Saving to '{filename}'...")
            buffer = b""
            while True:
                data = ser.read(1)
                if data:
                    f.write(data)
                    if data == b'\x1a':
                        print("[INFO] File received successfully.")
                        break
                else:
                    continue  # Timeout occurred, continue reading
    except serial.SerialException as e:
        print(f"[ERROR] Serial error: {e}")
    except KeyboardInterrupt:
        print("\n[INFO] Interrupted by user.")

def main():
    if len(sys.argv) < 3:
        print("Usage: python serial_file_receiver.py <port> <output_filename>")
        sys.exit(1)

    port = sys.argv[1]
    filename = sys.argv[2]

    receive_file(port, filename)

if __name__ == "__main__":
    main()
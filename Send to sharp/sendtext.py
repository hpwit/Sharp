# -*- coding: utf-8 -*-
import serial
import sys
import time
import os
import struct

def send_file_over_serial(file_path, serial_port):
    # Check if the file exists
    if not os.path.isfile(file_path):
        print(f"Error: File '{file_path}' not found.")
        return

    file_size = int(os.path.getsize(file_path))
    if file_size > 0xFFFF:
        print("Error: File too large (must be <= 65535 bytes for 2-byte size header).")
        return

    # Open serial port
    try:
        ser = serial.Serial(serial_port, baudrate=9600, bytesize=serial.EIGHTBITS,parity=serial.PARITY_NONE,stopbits=serial.STOPBITS_ONE, timeout=1)
        print(f"Opened serial port {serial_port}")
    except serial.SerialException as e:
        print(f"Error opening serial port {serial_port}: {e}")
        return

    try:
        # Send 2-byte big-endian file size
        # Send file contents byte by byte
        with open(file_path, "rb") as f:
            count = 0
            while (byte := f.read(1)):
                ser.write(byte)
                count += 1
                time.sleep(0.005)  # Optional small delay
            ser.write(0x1a)
        print(f"Sent {count} data bytes from '{file_path}' to '{serial_port}'")

    except Exception as e:
        print(f"Error during file transmission: {e}")
    finally:
        ser.close()
        print("Serial port closed.")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python sendtext.py <binary_file> <serial_port>")
        print("Example: python sendtext.py prog.bas COM3")
        sys.exit(1)


    file_path = sys.argv[1]
    serial_port = sys.argv[2]
    #address = sys.argv[3]
    send_file_over_serial(file_path, serial_port)
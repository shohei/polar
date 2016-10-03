import matplotlib.pyplot as plt
import re
import serial

pattern = re.compile(r'\d+\.\d')

ser = serial.Serial("/dev/tty.usbserial",115200)
i = 0
ii = []
res = []
while True:
    line = ser.readline()
    snw = pattern.findall(line)
    if snw:
        snw = float(snw[0])
        plt.plot(ii,res)
        plt.show()

        i = i+1 

ser.close()



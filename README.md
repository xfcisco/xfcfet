# xfcfet
my own version of neofetch that includes sys info, spotify info, and ascii picture

# Screenshots
![alt text](https://github.com/x86Cisco/xfcfet/blob/main/prev1.png)
![alt text](https://github.com/x86Cisco/xfcfet/blob/main/prev2.png)
![alt text](https://github.com/x86Cisco/xfcfet/blob/main/prev3.png)

# Requirments
python3 (and /usr/include/python3.8 libs)
cython
gcc
chafa
playerctl

# How to compile
if you dont want to use the compiled version i uploaded in the repo
then this is how to compile it yourself:
  1) ```pip3 install cython``` (or install with package manager)
  2) ```cython3 main.pyx --embed``` will output a main.c file
  3) ```gcc -Os -I /usr/include/python3.8 main.c -lpython3.8 -o xfcfet```  # this here will compile the C file generated make sure you have python installed to link its libs
  4) ```rm main.c``` cleaning up
  5) ```./xfcfet ~/Pictures/avatar.png```

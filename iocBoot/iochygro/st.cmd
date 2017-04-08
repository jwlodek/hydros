#!./bin/linux-x86_64/hygro

## You may have to change hygro to something else
## everywhere it appears in this file

epicsEnvSet("ENGINEER",  "kgofron x5283")
epicsEnvSet("LOCATION", "XF10IDD{RG:D2}")
epicsEnvSet("STREAM_PROTOCOL_PATH", "hygroApp/Db")
epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.10.0.255")

< envPaths

## configuration for stream
epicsEnvSet ("STREAM_PROTOCOL_PATH", ".:./hygroApp/src/protocol-files/")

## Register all support components
dbLoadDatabase("./dbd/hygro.dbd",0,0)
hygro_registerRecordDeviceDriver(pdbbase) 

#######  hygro via com-port #########################
### use RS232 over USB, ttyUSB0, baud = 9600. 
##
#drvAsynSerialPortConfigure "COM1", "/dev/ttyS0"
drvAsynSerialPortConfigure "COM1", "/dev/ttyUSB0"
asynOctetSetInputEos "COM1",0,"\r"
asynOctetSetOutputEos "COM1",0,"\r"
#asynSetOption ("COM1", 0, "baud", "115200")
asynSetOption ("COM1", 0, "baud", "9600")
asynSetOption ("COM1", 0, "bits", "8")
asynSetOption ("COM1", 0, "parity", "none")
asynSetOption ("COM1", 0, "stop", "1")
asynSetOption ("COM1", 0, "clocal", "Y")
asynSetOption ("COM1", 0, "crtscts", "N")


##############  hygro via Moxa TCP Server  #########
##
## drvAsynIPPortConfigure(portName, hostInfo, priority, noAutoConnect, noProcessEos)
#drvAsynIPPortConfigure("I404_1", "192.168.10.21:4001",0,0,0)
#drvAsynIPPortConfigure("I404_1", "10.3.2.52:4003",0,0,0)
#drvAsynIPPortConfigure("I404_1", "10.10.2.64:4003",0,0,0)
##
#dbLoadRecords("db/asyn.db","Sys=XF:10IDC-BI,Dev={i404:2},PORT=I404_1,ADDR=0")
#dbLoadRecords("db/asyn.db","Sys=XF:10IDC-BI,Dev={i404:2},PORT=COM1,ADDR=0")
dbLoadRecords("db/asyn.db","Sys=XF:10IDD-ES,Dev={Humid:1},PORT=COM1,ADDR=0")


## Load record instances
#dbLoadRecords("./db/hygro.db","user=iocuser")
#dbLoadTemplate "./db/hygro.substitutions"
dbLoadRecords("db/hygro.db")

## Run this to trace the stages of iocInit
#traceIocInit

iocInit()

## Start any sequence programs
#seq sncI400,"user=iocuser"

dbpf("XF:10IDC-BI{i404:2}Asyn.TB3","1")
dbpf("XF:10IDC-BI{i404:2}Asyn.TIB1","1")

###Streamdebug#################################################################
var streamDebug 0
###############################################################################

date
##EOF

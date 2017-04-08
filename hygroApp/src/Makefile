TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================
# Build the IOC application

PROD_IOC = hygro
# hygro.dbd will be created and installed
DBD += hygro.dbd

# hygro.dbd will be made up from these files:
hygro_DBD += base.dbd
hygro_DBD += stream.dbd
hygro_DBD += asyn.dbd
hygro_DBD += drvAsynIPPort.dbd
hygro_DBD += calcSupport.dbd
#http://epics.web.psi.ch/software/streamdevice/doc/setup.html#app
hygro_DBD += hygroAppInclude.dbd
#hygro_DBD += initTrace.dbd

# Add all the support libraries needed by this IOC
hygro_LIBS += calc
hygro_LIBS += stream
hygro_LIBS += asyn

# hygro_registerRecordDeviceDriver.cpp derives from hygro.dbd
hygro_SRCS += hygro_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
hygro_SRCS_DEFAULT += hygroMain.cpp
hygro_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#hygro_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
hygro_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE


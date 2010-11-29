# Add more folders to ship with the application, here
#qmlfiles.source = qml/spacerace
#qmlfiles.target = qml
#DEPLOYMENTFOLDERS = qmlfiles

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# Avoid auto screen rotation
DEFINES += ORIENTATIONLOCK

# Needs to be defined for Symbian
#DEFINES += NETWORKACCESS

symbian:TARGET.UID3 = 0xEC5D2BF4

# Define QMLJSDEBUGGER to allow debugging of QML in debug builds
# (This might significantly increase build time)
# DEFINES += QMLJSDEBUGGER

# If your application uses the Qt Mobility libraries, uncomment
# the following lines and add the respective components to the 
# MOBILITY variable. 
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    img/trackmask.xcf \
    img/trackmask.png \
    img/spaceship1.gif \
    img/fire2.gif \
    img/fire1.gif

RESOURCES += \
    spaceresources.qrc

# Add more folders to ship with the application, here
qmlfiles.source = qml/spacerace
qmlfiles.target = qml
audio.source = audio/
DEPLOYMENTFOLDERS = qmlfiles audio

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
CONFIG += mobility
MOBILITY += sensors multimedia

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
    img/fire1.gif \
    qml/spacerace/Spaceship.qml \
    qml/spacerace/RaceTrack.qml \
    qml/spacerace/main.qml \
    audio/alien.mp3

RESOURCES += \
    spaceresources.qrc

INCLUDEPATH += /home/richard/git/public/qt-mobility-intalled/include
INCLUDEPATH += /home/richard/git/public/qt-mobility-intalled/include/QtMobility
INCLUDEPATH += /home/richard/git/public/qt-mobility-intalled/include/QtSensors

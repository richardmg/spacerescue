#include <QtGui/QApplication>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include <QtMobility/qmobilityglobal.h>
#include <QtSensors/QSensor>
#include <QtSensors/QRotationSensor>
#include <QtSensors/QRotationReading>
#include <QtSensors/QRotationFilter>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<QRotationSensor>("QtMobility.sensors", 1, 1, "RotationSensor");
    qmlRegisterType<QRotationReading>("QtMobility.sensors", 1, 1, "RotationReading");

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);
    viewer.setMainQmlFile(QLatin1String("qml/spacerace/main.qml"));
    viewer.showExpanded();

    return app.exec();
}

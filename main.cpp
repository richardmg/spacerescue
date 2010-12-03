#include <QtGui>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include <QtMobility/qmobilityglobal.h>
#include <QtSensors/QSensor>
#include <QtSensors/QRotationSensor>
#include <QtSensors/QRotationReading>
#include <QtSensors/QRotationFilter>
#include <qorientationsensor.h>

using namespace QtMobility;

class ShipRotation : public QDeclarativeItem, QRotationFilter
{
    Q_OBJECT
    QRotationSensor sensor;
    Q_PROPERTY(float rotationX READ rotationX() NOTIFY rotationXChanged)
    Q_PROPERTY(float rotationY READ rotationY() NOTIFY rotationYChanged)
    Q_PROPERTY(float rotationZ READ rotationZ() NOTIFY rotationZChanged)

    float _rotationX;
    float _rotationY;
    float _rotationZ;
public:
    ShipRotation() : _rotationX(0), _rotationY(0), _rotationZ(0)
    {
        sensor.addFilter(this);
        sensor.start();
    }

    bool filter(QRotationReading *reading)
    {
        if (!isEnabled())
            return false;

        if (reading->x() != _rotationX) {
            _rotationX = reading->x();
            emit rotationXChanged(_rotationX);
        }
        if (reading->y() != _rotationY) {
            _rotationY = reading->y();
            emit rotationYChanged(_rotationY);
        }
        if (reading->z() != _rotationZ) {
            _rotationZ = reading->z();
            emit rotationZChanged(_rotationZ);
        }
        return false;
    }

    float rotationX() { return _rotationX; }
    float rotationY() { return _rotationY; }
    float rotationZ() { return _rotationZ; }

signals:
    void rotationXChanged(float rotationX);
    void rotationYChanged(float rotationY);
    void rotationZChanged(float rotationZ);
};

#include "main.moc"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    qmlRegisterType<ShipRotation>("SpaceDebris", 1, 0, "ShipRotation");

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);
    viewer.setResizeMode(QmlApplicationViewer::SizeRootObjectToView);
    viewer.setMainQmlFile(QLatin1String("qml/spacerace/main.qml"));
//    viewer.showNormal();
    viewer.showFullScreen();

    return app.exec();
}

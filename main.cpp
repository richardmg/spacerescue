#include <QtGui>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include <QtMobility/qmobilityglobal.h>
#include <QtSensors/QSensor>
#include <QtSensors/QRotationSensor>
#include <QtSensors/QRotationReading>
#include <QtSensors/QRotationFilter>
#include <qorientationsensor.h>
#include <QMediaPlayer>

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

class SpaceAudio: public QDeclarativeItem
{
    Q_OBJECT
    Q_PROPERTY(bool play READ playing() WRITE setPlay())
    Q_PROPERTY(QString source READ source() WRITE setSource)
    Q_PROPERTY(int volume READ volume() WRITE setVolume NOTIFY volumeChanged)
    Q_PROPERTY(int position READ position() WRITE setPosition)

    QMediaPlayer *mediaPlayer;
    QString _source;
    bool _play;
    int _volume;

public:
    SpaceAudio() : mediaPlayer(new QMediaPlayer(this)), _source(""), _play(false), _volume(100)
    {
    }

    bool playing() { return _play; }
    QString source() { return _source; }
    int volume() { return _volume; }
    int position() { return mediaPlayer->position(); }

    void setPlay(bool play)
    {
        if (_play == play)
            return;
        _play = play;
        play? mediaPlayer->play() : mediaPlayer->stop();
    }

    void setSource(QString source)
    {
        if (_source == source)
            return;
        _source = source;
         if (source.isEmpty()) {
            mediaPlayer->setMedia(QUrl());
            return;
        }
        mediaPlayer->setMedia(QUrl::fromLocalFile("/opt/usr/share/" + source));
        mediaPlayer->setVolume(_volume);
        if (_play)
            mediaPlayer->play();
    }

    void setVolume(int volume)
    {
        _volume = volume;
        mediaPlayer->setVolume(volume);
        emit volumeChanged(volume);
    }

    void setPosition(int position)
    {
        mediaPlayer->setPosition(position);
    }

signals:
    void volumeChanged(int volume);

};

#include "main.moc"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    qmlRegisterType<ShipRotation>("SpaceDebris", 1, 0, "ShipRotation");
    qmlRegisterType<SpaceAudio>("SpaceDebris", 1, 0, "SpaceAudio");

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);
    viewer.setResizeMode(QmlApplicationViewer::SizeRootObjectToView);
    viewer.setMainQmlFile(QLatin1String("qml/spacerace/main.qml"));
    viewer.showFullScreen();

    return app.exec();
}

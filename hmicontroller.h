#ifndef HMICONTROLLER_H
#define HMICONTROLLER_H

#include <QObject>
#include <QSharedMemory>
#include <QFile>

class HmiController : public QObject
{
    Q_OBJECT
public:
    explicit HmiController(QObject *parent = nullptr);
    ~HmiController();
    Q_INVOKABLE void setRPMValue(int value);
    Q_INVOKABLE void writeToGeodata(double lat, double lon, double speed);
    Q_INVOKABLE void startGeodataWriting();
    Q_INVOKABLE void stopGeodataWriting();
private:
    QSharedMemory shmem;
    QFile m_dataFile;
};

#endif // HMICONTROLLER_H

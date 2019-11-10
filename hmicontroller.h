#ifndef HMICONTROLLER_H
#define HMICONTROLLER_H

#include <QObject>
#include <QSharedMemory>

class HmiController : public QObject
{
    Q_OBJECT
public:
    explicit HmiController(QObject *parent = nullptr);
    Q_INVOKABLE void setRPMValue(int value);
private:
    QSharedMemory shmem;
};

#endif // HMICONTROLLER_H

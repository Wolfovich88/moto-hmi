#include "hmicontroller.h"
#include <QSharedMemory>
#include <QBuffer>
#include <QDataStream>
#include <QDebug>

HmiController::HmiController(QObject *parent) : QObject(parent)
{
    shmem.setKey("HmiSpeed");
}

void HmiController::setRPMValue(int value)
{
    QBuffer buffer;
    buffer.open(QBuffer::ReadWrite);
    QDataStream out(&buffer);
    out << value;
    int size = buffer.size();

    if (!shmem.create(size)) {
        qWarning() << "Unable to create shared memory segment.";
        return;
    }
    shmem.lock();
    char *to = static_cast <char*> (shmem.data());
    const char *from = buffer.data().data();
    memcpy(to, from, qMin(shmem.size(), size));
    shmem.unlock();
}

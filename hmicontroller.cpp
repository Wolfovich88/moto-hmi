#include "hmicontroller.h"
#include <QSharedMemory>
#include <QBuffer>
#include <QDataStream>
#include <QDir>
#include <QDebug>

HmiController::HmiController(QObject *parent) : QObject(parent)
{
    shmem.setKey("HmiSpeed");
    m_dataFile.setFileName(QDir::currentPath() + "/geodata.log");
}

HmiController::~HmiController()
{
    stopGeodataWriting();
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

void HmiController::writeToGeodata(double lat, double lon, double speed)
{
    if (m_dataFile.isOpen())
    {
        QTextStream stream(&m_dataFile);
        stream << lat << ";" << lon << ";" << speed << endl;
    }
}

void HmiController::startGeodataWriting()
{
    if (!m_dataFile.open(QFile::WriteOnly))
    {
        qWarning() << "Error to open file:" << m_dataFile.fileName() << m_dataFile.errorString();
        return;
    }
}

void HmiController::stopGeodataWriting()
{
    m_dataFile.close();
}

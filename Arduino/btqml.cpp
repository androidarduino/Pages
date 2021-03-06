#include "btqml.h"
#include <QDebug>

BTQML::BTQML(QQuickItem *parent) :
    QQuickItem(parent)
{
    worker = new BtWorker(&rfcomm);
    QObject::connect(worker, SIGNAL(messageArrived(QString)), this, SLOT(messageArrived(QString)));
    QObject::connect(this, SIGNAL(connected()), worker, SLOT(poll_result()));
    qDebug("btqml class created");
}

QString BTQML::receive_line()
{
    QString line = rfcomm.receiveLine(1000, 10);
    emit received_line(line);
    return line;
}

void BTQML::send_line(QString line)
{
    rfcomm.sendLine(line);
}

void BTQML::connect(QString device_name)
{
    m_device_name = device_name;
    rfcomm.connect(device_name);
    emit connected();
}

void BTQML::disconnect()
{
    rfcomm.disconnect();
}

QVariant BTQML::get_paired_devices()
{
    QMap<QString, QString> pd = rfcomm.getPairedDevices();
    QStringList list(pd.values());
    return QVariant::fromValue(list);
}

bool BTQML::get_enabled()
{
    return rfcomm.isEnabled();
}

QString BTQML::get_status()
{
    if (m_device_name == "") return "No Device Set";
    if (rfcomm.m_connected) return "Connected";
    return "Not Connected";
}

BTQML::ENCODING BTQML::get_encoding()
{
    return rfcomm.getLatin1Encoding() ? BTQML::Lating1 : BTQML::Utf8;
}

void BTQML::set_encoding(BTQML::ENCODING encoding)
{
    rfcomm.setLatin1Encoding(encoding == BTQML::Lating1);
}

QString BTQML::get_send_terminator()
{
    return rfcomm.getSendTerminator();
}

void BTQML::set_send_terminator(QString terminator)
{
    rfcomm.setSendTerminator(terminator);
}

QString BTQML::get_receive_terminator()
{
    return rfcomm.getReceiveTerminator();
}

void BTQML::set_receive_terminator(QString terminator)
{
    rfcomm.setReceiveTerminator(terminator);
}

QString BTQML::readAll()
{
    return rfcomm.readAll();
}

void BTQML::messageArrived(QString message)
{
    qDebug()<<"Message Arrived: " + message;
}

BtWorker::BtWorker(AndroidRfComm* rc)
{
    this->rfcomm = rc;
    moveToThread(&thread);
    thread.start();
    qDebug()<<"thread started for bt worker";
}

BtWorker::~BtWorker()
{
    qDebug()<<"closing thread for bt worker";
    thread.quit();
    qDebug()<<"waiting for thread to finish";
    thread.wait();
}

void BtWorker::poll_result()
{
    //Poll the JNI API for received message, if encountered a message, emit a signal
    QString result;
    while(true) {
        try {
            result = rfcomm->receiveLine(256, 1000);
        } catch (...)
        {
            continue;
        }
        if(result != "")
            emit messageArrived(result);
        qDebug()<<"get result: "<< result << ";";
    }
}

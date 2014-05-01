#include "btqml.h"
#include <QDebug>

BTQML::BTQML(QQuickItem *parent) :
    QQuickItem(parent)
{
    qDebug("btqml class created");
}

QString BTQML::receive_line()
{
    return rfcomm.receiveLine(1000, 100);
}

void BTQML::send_line(QString line)
{
    rfcomm.sendLine(line);
}

void BTQML::connect(QString device_name)
{
    m_device_name = device_name;
    rfcomm.connect(device_name);
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
    if (rfcomm.isConnected()) return "Connected";
    return "Not Connected";
}

BTQML::ENCODING BTQML::get_encoding()
{
    return rfcomm.getLatin1Encoding() ? BTQML::Lating1 : BTQML::Utf8;
}

QString BTQML::get_terminator()
{
    return rfcomm.getSendTerminator();
}

void BTQML::set_encoding(BTQML::ENCODING encoding)
{
    rfcomm.setLatin1Encoding(encoding == BTQML::Lating1);
}

void BTQML::set_terminator(QString terminator)
{
    rfcomm.setSendTerminator(terminator);
    rfcomm.setReceiveTerminator(terminator);
}

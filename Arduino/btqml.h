#ifndef BTQML_H
#define BTQML_H

#include <QQuickItem>
#include <QThread>
#include "qtquick2applicationviewer/androidrfcomm.h"

class BtWorker : public QObject
{
    Q_OBJECT
public:
    BtWorker();
    ~BtWorker();
public slots:
    void poll_result();
    void send_line(QString line);
    void connect(Qstring device_name);
    void get_paired_devices();
signals:
    void messageArrived(QString line);
    void pairedDeviceArrived(QVariant devices);
protected:
    QThread thread;
    AndroidRfComm rfcomm;
};

class BTQML : public QQuickItem
{
    enum ENCODING {
        Utf8, Lating1
    };
    Q_OBJECT
    Q_PROPERTY(QVariant paired_devices READ get_paired_devices)
    Q_PROPERTY(bool enabled READ get_enabled)
    Q_PROPERTY(QString status READ get_status)
    Q_PROPERTY(ENCODING encoding READ get_encoding WRITE set_encoding)
    Q_PROPERTY(QString send_terminator READ get_send_terminator WRITE set_send_terminator)
    Q_PROPERTY(QString receive_terminator READ get_receive_terminator WRITE set_receive_terminator)
    Q_PROPERTY(QString received READ receive_line NOTIFY received_line)
public:
    explicit BTQML(QQuickItem *parent = 0);
signals:
    void connected();
    void received_line(QString line);
public slots:
    void send_line(QString line);
    QString receive_line();
    void connect(QString device_name);
    void disconnect();
    QString readAll();
    void messageArrived(QString message);
    void get_paired_devices();
protected:
    bool get_enabled();
    QString get_status();
    BTQML::ENCODING get_encoding();
    void set_encoding(BTQML::ENCODING encoding);
    QString get_send_terminator();
    void set_send_terminator(QString terminator);
    QString get_receive_terminator();
    void set_receive_terminator(QString terminator);
private:
    QString m_device_name;
    BtWorker* worker;
};

#endif // BTQML_H

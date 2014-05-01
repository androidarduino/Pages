#ifndef BTQML_H
#define BTQML_H

#include <QQuickItem>
#include "androidrfcomm.h"

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
    Q_PROPERTY(QString terminator READ get_terminator WRITE set_terminator)
public:
    explicit BTQML(QQuickItem *parent = 0);
signals:
    void connected();
    void receive_line(QString line);
public slots:
    void send_line(QString line);
    QString receive_line();
    void connect(QString device_name);
    void disconnect();
protected:
    QVariant get_paired_devices();
    bool get_enabled();
    QString get_status();
    BTQML::ENCODING get_encoding();
    QString get_terminator();
    void set_encoding(BTQML::ENCODING encoding);
    void set_terminator(QString terminator);
private:
    AndroidRfComm rfcomm;
    QString m_device_name;
};

#endif // BTQML_H

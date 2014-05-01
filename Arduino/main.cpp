#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include "btqml.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<BTQML>("BTQML", 1, 0, "BTQML");

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/Arduino/main.qml"));
    viewer.showExpanded();

    return app.exec();
}

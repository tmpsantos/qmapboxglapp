#ifdef QT_WIDGETS_LIB
#include <QApplication>
#else
#include <QGuiApplication>
#endif

#include <QIcon>
#include <QQmlApplicationEngine>
#include <qqml.h>

#include "qcheapruler.hpp"

int main(int argc, char *argv[])
{
    qputenv("QT_QUICK_CONTROLS_STYLE", "material");
    qputenv("QT_QUICK_CONTROLS_MATERIAL_THEME", "Dark");
    qputenv("QT_QUICK_CONTROLS_MATERIAL_ACCENT", "White");

#ifdef QT_WIDGETS_LIB
    QApplication app(argc, argv);
#else
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
#endif

    app.setWindowIcon(QIcon(":icon.png"));

    qmlRegisterType<QCheapRuler>("com.mapbox.cheap_ruler", 1, 0, "CheapRuler");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:qml/Main.qml")));

    return app.exec();
}

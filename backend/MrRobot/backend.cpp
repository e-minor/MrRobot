#include <QtQml>
#include <QtQml/QQmlContext>
#include "backend.h"
#include "mytype.h"
#include "audiorecorder.h"


void BackendPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("MrRobot"));

    qmlRegisterType<MyType>(uri, 1, 0, "MyType");
    qmlRegisterType<AudioRecorder>(uri, 1, 0, "AudioRecorder");
}

void BackendPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}


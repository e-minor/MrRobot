#include "voicerecognition.h"

#include <QFile>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QStandardPaths>
#include <QDir>

VoiceRecognition::VoiceRecognition(QObject *parent) :
    QObject(parent)
{
}

void VoiceRecognition::request(QString filename)
{
    QFile audioFile(getFilePath(filename));
    audioFile.open(QIODevice::ReadOnly);
    QByteArray audioData = audioFile.readAll();
    QNetworkAccessManager* networkManager = new QNetworkAccessManager();
    QNetworkRequest networkRequest;

    networkRequest.setUrl(QUrl("https://api.wit.ai/message?v=20150825&q=hello"));

    networkRequest.setRawHeader("Authorization","Bearer FMGHCIPQV7PCYLIY5QLUH76XJXX2HAID");
    //networkRequest.setHeader(QNetworkRequest::ContentTypeHeader, "audio/wav");
    connect(networkManager, &QNetworkAccessManager::finished, this, &VoiceRecognition::requestReplied);

    networkManager->post(networkRequest, audioData);
}

void VoiceRecognition::requestReplied(QNetworkReply *reply)
{
    QByteArray bytes = reply->readAll();
    QString result(bytes);

    qDebug() << "Voice Recognition Result";
    qDebug() << result;
}


QString VoiceRecognition::getFilePath(const QString filename) const
{
    QString writablePath = QStandardPaths::
            writableLocation(QStandardPaths::DataLocation);
    qDebug() << "writablePath: " << writablePath;

    QString absolutePath = QDir(writablePath).absolutePath();
    qDebug() << "absoluePath: " << absolutePath;

    // We need to make sure we have the path for storage
    QDir dir(absolutePath);
    if ( dir.mkdir(absolutePath) ) {
        qDebug() << "Successfully created the path!";
    }

    QString path = absolutePath + "/" + filename;

    qDebug() << "path: " << path;

    return path;
}

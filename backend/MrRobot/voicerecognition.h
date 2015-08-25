#ifndef VOICERECOGNITION_H
#define VOICERECOGNITION_H

#include <QObject>
#include <QNetworkReply>
#include <QUrl>

class VoiceRecognition : public QObject
{
    Q_OBJECT
public:
    explicit VoiceRecognition(QObject *parent = 0);

    Q_INVOKABLE void request(QString filename);

signals:

public slots:

private:
    QString getFilePath(const QString filename) const;

private slots:
    void requestReplied(QNetworkReply *reply);


};

#endif // VOICERECOGNITION_H

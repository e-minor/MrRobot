#include <QUrl>
#include <QStandardPaths>
#include <QDir>

#include "audiorecorder.h"

AudioRecorder::AudioRecorder(QObject *parent) : QObject(parent)
{
    m_audioRecorder = new QAudioRecorder( this );
    QAudioEncoderSettings audioSettings;
    audioSettings.setCodec("audio/PCM");
    audioSettings.setQuality(QMultimedia::HighQuality);
    m_audioRecorder->setEncodingSettings(audioSettings);
    // https://forum.qt.io/topic/42541/recording-audio-using-qtaudiorecorder/2
    m_audioRecorder->setContainerFormat("wav");
    m_recording = false;
}

const bool AudioRecorder::recording() const
{
    return m_recording;
}

void AudioRecorder::setRecording(bool recording ) {
    if (m_recording == recording)
        return;

    m_recording = recording;
    emit recordingChanged(m_recording);
}


void AudioRecorder::record()
{
    qDebug() << "Entering record!";

    if ( m_audioRecorder->state() == QMediaRecorder::StoppedState ) {
        qDebug() << "recording....! ";

        m_audioRecorder->record ( );

        m_recording = true;
        qDebug() << "m_recording: " << m_recording;
        emit recordingChanged(m_recording);
    }
}

void AudioRecorder::stop()
{
    qDebug() << "Entering stop!";

    if ( m_audioRecorder->state() == QMediaRecorder::RecordingState ) {
        qDebug() << "Stopping....";
        m_audioRecorder->stop();
        m_recording = false;
        emit recordingChanged(m_recording);
    }
}

QString AudioRecorder::name() const
{
    return m_name;
}

void AudioRecorder::setName(QString name)
{
    if (m_name == name)
        return;

    m_name = name;
    emit nameChanged(name);

    // at the same time update the path
    m_path = QUrl(getFilePath(name));

    // set the path
    m_audioRecorder->setOutputLocation(m_path);
}

QStringList AudioRecorder::supportedAudioCodecs() {
    return m_audioRecorder->supportedAudioCodecs();
}

QStringList AudioRecorder::supportedContainers() {
    return m_audioRecorder->supportedContainers();
}


QString AudioRecorder::getFilePath(const QString filename) const
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


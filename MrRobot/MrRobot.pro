TEMPLATE = aux
TARGET = MrRobot

RESOURCES += MrRobot.qrc

QML_FILES += $$files(*.qml,true) \
             $$files(*.js,true)

CONF_FILES +=  MrRobot.apparmor \
               MrRobot.desktop \
               $$files(*.png,true)

AP_TEST_FILES += tests/autopilot/run \
                 $$files(tests/*.py,true)

OTHER_FILES += $${CONF_FILES} \
               $${QML_FILES} \
               $${AP_TEST_FILES}

#specify where the qml/js files are installed to
qml_files.path = /MrRobot
qml_files.files += $${QML_FILES}

#specify where the config files are installed to
config_files.path = /MrRobot
config_files.files += $${CONF_FILES}

INSTALLS+=config_files qml_files


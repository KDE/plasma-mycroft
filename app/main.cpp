#include <QApplication>
#include <QCommandLineParser>
#include <QQuickView>

int main(int argc, char **argv)
{
    QApplication app(argc, argv);
    QCommandLineParser parser;

    QQuickView view;
    auto widthOption = QCommandLineOption("width", "width", "width");
    auto heightOption = QCommandLineOption("height", "height", "height");
    parser.addOptions({widthOption, heightOption});
    parser.parse(QCoreApplication::arguments());
    parser.process(app);

    int width = parser.value(widthOption).toInt();
    int height = parser.value(heightOption).toInt();

    view.setResizeMode(QQuickView::SizeRootObjectToView);
    if (width > 0) {
        qDebug() << "setting width";
        view.setWidth(width);
        view.setMinimumWidth(width);
        view.setMaximumWidth(width);
    }
    if (height > 0) {
        view.setWidth(height);
        view.setMinimumWidth(height);
        view.setMaximumWidth(height);
    }

    view.setSource(QUrl::fromLocalFile("/home/david/projects/kde5/src/extragear/utils/plasma-mycroft/app/shell.qml"));
    view.show();

    app.exec();
}

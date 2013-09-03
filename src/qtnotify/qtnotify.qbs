import qbs

Group {
    name: "qtnotify"
    condition: qbs.targetOS.contains("unix") && !qbs.targetOS.contains("osx") && project.useDBus
    files: ["notifications.h", "notifications.cpp"]
}

import qbs

Group {
    name: "QtSingleApplication"
    condition: !project.useQtSingleApplicationFromSystem
    Depends { name: "Qt.core" }
    Depends { name: "Qt.widgets"; condition: project.withGui; }
    files: {
        var files = ["qtlocalpeer.h", "qtlocalpeer.cpp"];
        if (project.withGui) {
            files.push("qtsingleapplication.h");
            files.push("qtsingleapplication.cpp");
        } else {
            files.push("qtsinglecoreapplication.h");
            files.push("qtsinglecoreapplication.cpp");
        }
        return files;
    }
}


import qbs

Group {
    name: "LineEdit"
    condition: project.withGui
    files: [
        "src/lineedit.h", "src/lineedit.cpp",
        "resources/lineeditimages.qrc"
    ]
}

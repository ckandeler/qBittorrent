import qbs

Group {
    name: "Power Management (Unix)"
    condition: project.withGui && qbs.targetOS.contains("unix") && !qbs.targetOS.contains("osx")
    files: ["powermanagement_x11.h", "powermanagement_x11.cpp"]
}

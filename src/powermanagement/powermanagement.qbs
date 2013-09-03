import qbs

Group {
    name: "Power Management"
    condition: project.withGui
    files: ["powermanagement.h", "powermanagement.cpp"]
}


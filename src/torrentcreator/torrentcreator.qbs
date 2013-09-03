import qbs

Group {
    name: "torrentcreator"
    condition: project.withGui
    files: [
        "createtorrent.ui",
        "torrentcreatordlg.h", "torrentcreatordlg.cpp",
        "torrentcreatorthread.h", "torrentcreatorthread.cpp"
    ]
}


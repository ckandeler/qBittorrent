import qbs

Group {
    name: "searchengine"
    condition: project.withGui
    files: [
        "engineselect.ui",
        "engineselectdlg.h", "engineselectdlg.cpp",
        "pluginsource.h", "pluginsource.ui",
        "search.ui",
        "search.qrc",
        "searchengine.h", "searchengine.cpp",
        "searchlistdelegate.h",
        "searchsortmodel.h",
        "searchtab.h", "searchtab.cpp",
        "supportedengines.h"
    ]        
}


import qbs

Group {
    name: "properties"
    condition: project.withGui
    files: [
        "downloadedpiecesbar.h", "downloadedpiecesbar.cpp",
        "peer.ui",
        "peeraddition.h",
        "peerlistdelegate.h",
        "peerlistsortmodel.h",
        "peerlistwidget.h", "peerlistwidget.cpp",
        "pieceavailabilitybar.h", "pieceavailabilitybar.cpp",
        "propertieswidget.h", "propertieswidget.cpp", "propertieswidget.ui",
        "proplistdelegate.h",
        "proptabbar.h", "proptabbar.cpp",
        "trackerlist.h", "trackerlist.cpp",
        "trackersadditiondlg.h", "trackersadditiondlg.ui"
    ]
}


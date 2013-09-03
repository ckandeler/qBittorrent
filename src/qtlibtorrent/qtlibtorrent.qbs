import qbs

Group {
    name: "qtlibtorrent"
    files: {
        var files = [
                "bandwidthscheduler.h",
                "filterparserthread.h",
                "qbtsession.h", "qbtsession.cpp",
                "qtorrenthandle.h", "qtorrenthandle.cpp",
                "torrentspeedmonitor.h", "torrentspeedmonitor.cpp",
                "trackerinfos.h"
            ];
        if (project.withGui) {
            files.push("shutdownconfirm.h");
            files.push("torrentmodel.h");
            files.push("torrentmodel.cpp");
        }
        return files;
    }
}

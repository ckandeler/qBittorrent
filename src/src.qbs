import qbs
import qbs.Probes

import "geoip/geoip.qbs" as GeoIp
import "lineedit/lineedit.qbs" as LineEdit
import "preferences/preferences.qbs" as Preferences
import "properties/properties.qbs" as Properties
import "powermanagement/powermanagement.qbs" as PowerManagement
import "powermanagement/powermanagement-unix.qbs" as PowerManagementUnix
import "qtlibtorrent/qtlibtorrent.qbs" as QtLibTorrent
import "qtnotify/qtnotify.qbs" as QtNotify
import "qtsingleapp/qtsingleapp.qbs" as QtSingleApp
import "rss/rss.qbs" as Rss
import "searchengine/searchengine.qbs" as SearchEngine
import "torrentcreator/torrentcreator.qbs" as TorrentCreator
import "tracker/tracker.qbs" as Tracker
import "webui/webui.qbs" as WebUi

CppApplication {
    name: project.withGui ? "qbittorrent" : "qbittorrent-nox"

    Depends { name: "Qt.core" }
    Depends {
        condition: project.withGui
        name: "Qt.widgets"
    }
    Depends {
        condition: project.withGui
        name: "Qt.xml"
    }
    Depends {
        condition: project.withDBus && qbs.targetOS.contains("unix") && !qbs.targetOS.contains("osx")
        name: "Qt.dbus"
    }
    Depends { name: "Qt.network" }
    Depends { name: "translations" }

    Probes.PkgConfigProbe {
        id: libtorrent_pkgconfig
        name: "libtorrent-rasterbar"
    }

    cpp.cxxFlags: {
        var flags = [];
        if (qbs.targetOS.contains("unix") && !qbs.targetOS.contains("osx")) {
            flags.push("-Wformat");
            flags.push("-Wformat-security");
            flags = flags.concat(libtorrent_pkgconfig.cflags);
        }
        return flags;
    }

    cpp.linkerFlags: {
        var flags = [];
        if (qbs.targetOS.contains("unix") && !qbs.targetOS.contains("osx")) {
            flags.push("-rdynamic");
            flags = flags.concat(libtorrent_pkgconfig.libs);
        }
        return flags;
    }

    cpp.dynamicLibraries: {
        var libs = []
        if (qbs.targetOS.contains("unix") && !qbs.targetOS.contains("osx")) {
            libs.push("boost_system-mt");
            libs.push("boost_thread-mt");
            libs.push("crypto");
            libs.push("pthread");
            libs.push("ssl");
            libs.push("z");
        }
        return libs;
    }

    cpp.defines: {
        var defines = [];
        defines.push('VERSION="v' + project.version + '"');
        defines.push("VERSION_MAJOR=" + project.versionMajor);
        defines.push("VERSION_MINOR=" + project.versionMinor);
        defines.push("VERSION_BUGFIX=" + project.versionPatch);
        defines.push("QT_NO_CAST_TO_ASCII");
        defines.push("QT_USE_FAST_CONCATENATION");
        defines.push("QT_USE_FAST_OPERATOR_PLUS");

        // Fixes compilation with Boost >= v1.46 where boost
        // filesystem v3 is the default.
        defines.push("BOOST_FILESYSTEM_VERSION=2");

        if (!project.withGui)
            defines.push("DISABLE_GUI");
        // TODO: QBT_STATIC_QT
        if (qbs.buildVariant == "release") {
            defines.push("QT_NO_DEBUG_OUTPUT");
            print("Disabling debug output");
        }
        return defines;
    }

    cpp.includePaths: {
        var includes = [path];
        if (geoIpGroup.condition)
            includes.push(geoIpGroup.prefix);
        if (lineEdit.condition)
            includes.push(lineEdit.prefix + "src");
        if (preferences.condition)
            includes.push(preferences.prefix);
        if (properties.condition)
            includes.push(properties.prefix);
        if (powerManagement.condition)
            includes.push(powerManagement.prefix);
        if (qtLibTorrent.condition)
            includes.push(qtLibTorrent.prefix);
        if (qtNotify.condition)
            includes.push(qtNotify.prefix);
        if (qtSingleApp.condition)
            includes.push(qtSingleApp.prefix);
        if (rss.condition)
            includes.push(rss.prefix);
        if (searchEngine.condition)
            includes.push(searchEngine.prefix);
        if (torrentCreator.condition)
            includes.push(torrentCreator.prefix);
        if (tracker.condition)
            includes.push(tracker.prefix);
        if (webUi.condition)
            includes.push(webUi.prefix);
        return includes;
    }


    GeoIp {
        id: geoIpGroup
        prefix: "geoip/"
    }

    LineEdit {
        id: lineEdit
        prefix: "lineedit/"
    }

    Preferences {
        id: preferences
        prefix: "preferences/"
    }

    Properties {
        id: properties
        prefix: "properties/"
    }

    PowerManagement {
        id: powerManagement
        prefix: "powermanagement/"
    }

    PowerManagementUnix {
        prefix: powerManagement.prefix
    }

    QtLibTorrent {
        id: qtLibTorrent
        prefix: "qtlibtorrent/"
    }

    QtNotify {
        id: qtNotify
        prefix: "qtnotify/"
    }

    QtSingleApp {
        id: qtSingleApp
        prefix: "qtsingleapp/"
    }

    Rss {
        id: rss
        prefix: "rss/"
    }

    SearchEngine {
        id: searchEngine
        prefix: "searchengine/"
    }

    TorrentCreator {
        id: torrentCreator
        prefix: "torrentcreator/"
    }

    Tracker {
        id: tracker
        prefix: "tracker/"
    }

    WebUi {
        id: webUi
        prefix: "webui/"
    }

    // TODO: Groups as dedicated items in their own files?
    Group {
        name: "Resources"
        files: [ 
            "about.qrc",
            "icons.qrc",
//            "lang.qrc" TODO: Create this dynamically with whatever trabslations are there
        ]
    }

    Group {
        name: "general"
        files: [
            "dnsupdater.h", "dnsupdater.cpp",
            "downloadthread.h", "downloadthread.cpp",
            "fs_utils.h", "fs_utils.cpp",
            "filesystemwatcher.h",
            "main.cpp",
            "misc.h", "misc.cpp",
            "qinisettings.h",
            "scannedfoldersmodel.h", "scannedfoldersmodel.cpp",
            "smtp.h", "smtp.cpp",
            "stacktrace.h",
            "torrentpersistentdata.h"
        ]
    }

    Group {
        name: "headless"
        condition: !project.withGui
        files: "headlessloader.h"
    }

    Group {
        name: "GUI"
        condition: project.withGui
        files: [
            "about.ui",
            "about_imp.h",
            "addnewtorrentdialog.h", "addnewtorrentdialog.cpp", "addnewtorrentdialog.ui",
            "autoexpandabledialog.h", "autoexpandabledialog.cpp", "autoexpandabledialog.ui",
            "bandwidth_limit.ui",
            "confirmdeletiondlg.ui",
            "deletionconfirmationdlg.h",
            "downloadfromurldlg.h", "downloadfromurldlg.ui",
            "executionlog.h", "executionlog.cpp", "executionlog.ui",
            "hidabletabwidget.h",
            "ico.h", "ico.cpp",
            "iconprovider.h", "iconprovider.cpp",
            "login.ui",
            "loglistwidget.h", "loglistwidget.cpp",
            "mainwindow.h", "mainwindow.cpp", "mainwindow.ui",
            "preview.ui",
            "previewlistdelegate.h",
            "previewselect.h", "previewselect.cpp",
            "reverseresolution.h",
            "sessionapplication.h", "sessionapplication.cpp",
            "speedlimitdlg.h",
            "statusbar.h",
            "torrentcontentfiltermodel.h", "torrentcontentfiltermodel.cpp",
            "torrentcontentmodel.h", "torrentcontentmodel.cpp",
            "torrentcontentmodelfile.h", "torrentcontentmodelfile.cpp",
            "torrentcontentmodelfolder.h", "torrentcontentmodelfolder.cpp",
            "torrentcontentmodelitem.h", "torrentcontentmodelitem.cpp",
            "torrentimportdlg.h", "torrentimportdlg.cpp", "torrentimportdlg.ui",
            "trackerlogin.h",
            "transferlistdelegate.h",
            "transferlistsortmodel.h",
            "transferlistfilterswidget.h",
            "transferlistwidget.h", "transferlistwidget.cpp",
            "updownratiodlg.h", "updownratiodlg.cpp", "updownratiodlg.ui"
        ]
    }

    Group {
        name: "Program Updater"
        condition: project.withGui && (qbs.targetOS.contains("windows") || qbs.targetOS.contains("osx"))
        files: ["programupdater.h", "programupdater.cpp"]
    }

    Group {
        name: "QMacApplication"
        condition: project.withGui && qbs.targetOS.contains("osx")
        files: ["qmacapplication.h", "qmacapplication.cpp"]
    }
}

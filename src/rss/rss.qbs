import qbs

Group {
    name: "rss"
    condition: project.withGui
    files: [
        "automatedrssdownloader.h", "automatedrssdownloader.cpp", "automatedrssdownloader.ui",
        "cookiesdlg.h", "cookiesdlg.cpp", "cookiesdlg.ui",
        "feedlistwidget.h", "feedlistwidget.cpp",
        "rss.ui",
        "rss_imp.h", "rss_imp.cpp",
        "rssarticle.h", "rssarticle.cpp",
        "rssdownloadrule.h", "rssdownloadrule.cpp",
        "rssdownloadrulelist.h", "rssdownloadrulelist.cpp",
        "rssfeed.h", "rssfeed.cpp",
        "rssfile.h", "rssfile.cpp",
        "rssfolder.h", "rssfolder.cpp",
        "rssmanager.h", "rssmanager.cpp",
        "rssparser.h", "rssparser.cpp",
        "rsssettings.h",
        "rsssettingsdlg.h", "rsssettingsdlg.cpp", "rsssettingsdlg.ui"
    ]
}

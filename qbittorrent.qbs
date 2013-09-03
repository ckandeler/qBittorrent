import qbs

Project {
    name: "qbittorrent"

    property string version: "3.1.0alpha"
    property int versionMajor: 3
    property int versionMinor: 1
    property int versionPatch: 0

    property bool withGui: true
    property bool useQtSingleApplicationFromSystem: false
    property bool embedGeoIp: false
    property bool useDBus: true

    references: [
        "src/src.qbs",
        "src/lang/lang.qbs"
    ]
}

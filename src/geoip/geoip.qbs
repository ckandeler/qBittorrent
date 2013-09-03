import qbs

Group {
    name: "Geo IP"
    id: geoIpGroup
    property bool embedDatabase: project.embedGeoIp && File.exists(prefix + "GeoIP.dat")
    files: {
        var files = ["geoipmanager.h", "geoipmanager.cpp"]
        if (embedDatabase)
            files.push("geoip.qrc");
        return files;
    }
    cpp.defines: geoIpGroup.embedDatabase ? base.concat("WITH_GEOIP_EMBEDDED") : base
}

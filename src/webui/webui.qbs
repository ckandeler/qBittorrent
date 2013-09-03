import qbs

Group {
    name: "Web UI"
    files: [
        "btjson.h", "btjson.cpp",
        "httpconnection.h", "httpconnection.cpp",
        "httprequestparser.h", "httprequestparser.cpp",
        "httpresponsegenerator.h", "httpresponsegenerator.cpp",
        "httpserver.h", "httpserver.cpp",
        "json.h", "json.cpp",
        "jsondict.h", "jsondict.cpp",
        "jsonlist.h", "jsonlist.cpp",
        "prefjson.h", "prefjson.cpp",
        "webui.qrc"
    ]
}

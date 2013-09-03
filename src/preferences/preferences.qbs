import qbs

Group {
    name: "Preferences"
    files: {
        var files = ["preferences.h"];
        if (project.withGui) {
            files.push("advancedsettings.h");
            files.push("options_imp.h");
            files.push("options_imp.cpp");
            files.push("options.ui");
        }
        return files;
    }
}

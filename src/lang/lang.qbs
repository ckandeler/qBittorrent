import qbs

Product {
    type: "qm"
    name: "translations"
    Depends { name: "Qt.core" }
    files: "*.ts"
    destinationDirectory: "src/lang"
}

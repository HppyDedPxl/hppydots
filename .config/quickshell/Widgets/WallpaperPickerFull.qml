import "../Appearance"
import "../Services"
import Qt.labs.folderlistmodel
import QtQuick
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick.Controls

Component {
    
    Rectangle {
        id: mainPicker
        property var padding: 8
        property alias wallpaperFolder: base.wallpaperFolder

        width: padding + (192 + padding) * 7 + 60
        height: (padding + (108 + padding) * 2) + 200
        color: AppearanceProvider.nativeBackgroundColor
        radius: AppearanceProvider.rounding

        function urlToPathString(url){
            return url.toString().substring(7);
        }

        
        ColumnLayout {
            anchors.fill: parent

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                color:'transparent'
                Text {
                    color:AppearanceProvider.textColor
                    font.pointSize:14
                    anchors.centerIn:parent
                    text: "Current Folder: " + urlToPathString(Qt.resolvedUrl(wallpaperFolder))
                }
            }

            Rectangle {
                id: base
                property var padding: 8
                property var baseColor: Qt.lighter(AppearanceProvider.nativeBackgroundColor)
                property var wallpaperFolder: Qt.resolvedUrl(WallpaperProvider.config.defaultWallpaperFolder)        
                property var pendingLoading : false;

                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.leftMargin: 20
                Layout.rightMargin: 20

                clip: true
  
                color: baseColor
                radius: AppearanceProvider.rounding

                Rectangle {
                    id: cliptangle
                    clip: true
                    anchors.fill: parent
                    anchors.leftMargin: base.padding * 2
                    anchors.topMargin: base.padding * 2
                    anchors.bottomMargin: base.padding * 2
                    color: 'transparent'
                    visible: !base.pendingLoading

                    GridView {
                        id : gridView
                        anchors.fill: parent
                        cellHeight: 108 + base.padding
                        cellWidth: 192 + base.padding

                        model: SortFilterProxyModel{
                            model: FolderListModel {
                                id: folderModel

                                folder: wallpaperFolder // Or use relative paths like "./"
                                nameFilters: ["*.png", "*.jpg", "*.webp", "*.jpeg", "*.mp4"] // Optional filters
                                showFiles: true
                                showDirs: true
                                showDirsFirst: true
                                showDotAndDotDot: true
                            }
                            filters:[
                                ValueFilter {
                                    roleName: "fileName"
                                    value: "."
                                    inverted: true
                                },
                                ValueFilter {
                                    roleName: "fileName"
                                    value: "thumbs"
                                    inverted: true
                                }
                            ]
                        }

                        delegate: DelegateChooser {
                            id: choose
                            role:"fileIsDir"
                            DelegateChoice{ roleValue: true; delegate: WallpaperGridFolderEntry{} }
                            DelegateChoice{ roleValue: false; delegate: Component { WallpaperGridImageEntry {
                                baseFolderPath : wallpaperFolder
                                onPressed:(path)=>{
                                    WallpaperProvider.setWallpaper(screen, path, applyColorScheme.checked);
                                }
                            } }}
                        }

                    }

                }

                Rectangle{
                    visible: base.pendingLoading
                    Text{
                        text:"Pending loading"
                    }
                }

            }


            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                color:'transparent'
                RowLayout {
                    anchors.fill:parent
                    anchors.leftMargin:100
                    anchors.rightMargin:100
                    CheckBox{
                        id: applyColorScheme
                        checked: false
                        text: "Apply Color Scheme"
                        Layout.fillWidth :false
                    }

                    Button {
                        text: "Generate Thumbnails"
                        Layout.fillWidth :false
                        onClicked:{
                            base.pendingLoading = true
                            WallpaperProvider.generateThumbnailsInFolder(wallpaperFolder,()=>{
                                base.pendingLoading = false
                                gridView.reload()
                            });
                        }
                    }

                    Button {
                        text: "Set As Default Folder"
                        Layout.fillWidth: false
                        onClicked: {
                            WallpaperProvider.setDefaultWallpaperFolder(wallpaperFolder)
                        }
                    }           
                }
            }

        }

    }

}



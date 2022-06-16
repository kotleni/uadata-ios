import SwiftUI

struct ContentView: View {
    @State var selection: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            StatView()
                .tag(0)
                .tabItem {
                    Label("tab_stat".localized, systemImage: "doc.plaintext")
                }
            MapView()
                .tag(1)
                .tabItem {
                    Label("tab_map".localized, systemImage: "map")
                        .contextMenu {
                            
                        }
                }
            AboutView()
                .tag(2)
                .tabItem {
                    Label("tab_about".localized, systemImage: "info.circle")
                }
            
        }
        .navigationTitle(Text(selection == 0 ? "title_stat".localized : selection == 1 ? "title_map".localized : "title_about".localized))
    }
    
}

struct MapView: View {
    var body: some View {
        WebView(url: "https://upload.wikimedia.org/wikipedia/commons/4/4f/2022_Russian_invasion_of_Ukraine.svg")
    }
    
    private func openLink(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}

struct AboutView: View {
    var body: some View {
        VStack {
            Form {
                Section {
                    Button {
                        openLink(url: "https://github.com/kotleni/uadata-ios")
                    } label: {
                        Text("link_github".localized)
                    }
                    .foregroundColor(Color("LinkColor"))

                    Button {
                        openLink(url: "https://uadata.net/api")
                    } label: {
                        Text("link_uadata".localized)
                    }
                    .foregroundColor(Color("LinkColor"))
                    
                    Button {
                        openLink(url: "https://uk.wikipedia.org/wiki/Російське_вторгнення_в_Україну_(2022)")
                    } label: {
                        Text("link_wiki".localized)
                    }
                    .foregroundColor(Color("LinkColor"))

                } header: {
                    Text("header_links")
                }
                
                Section {
                    Text("about_version")
                        .foregroundColor(Color("TipColor"))
                    Text("about_developer")
                        .foregroundColor(Color("TipColor"))
                } header: {
                    Text("header_desc")
                }
            }
        }
    }
    
    private func openLink(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}

struct StatView: View {
    private let groundItems = [
        "people", "bbm", "tanks", "artilery", "rszv", "ppo", "auto"
    ]
    
    private let airItems = [
        "planes", "helicopters", "bpla"
    ]
    
    private let waterItems = [
        "ships"
    ]
    
    @State private var dataGroundDict: Dictionary<String, Data> = Dictionary()
    @State private var dataAirDict: Dictionary<String, Data> = Dictionary()
    @State private var dataWaterDict: Dictionary<String, Data> = Dictionary()
    
    var body: some View {
        Form {
            Section(content: {
                ForEach(dataGroundDict.keys.sorted(), id: \.self) { key in
                    Text("\(Text("item_\(key)".localized)): \(dataGroundDict[key]!.value)")
                        .contextMenu {
                            Button {
                                openLink(url: dataGroundDict[key]!.refUrl)
                            } label: {
                                Text("btn_ref".localized)
                            }
                            Button {
                                openLink(url: dataGroundDict[key]!.url)
                            } label: {
                                Text("btn_uadata")
                            }
                        }
                }
            }, header: {
                Text("type_ground".localized)
            })
            
            Section(content: {
                ForEach(dataAirDict.keys.sorted(), id: \.self) { key in
                    Text("\(Text("item_\(key)".localized)): \(dataAirDict[key]!.value)")
                        .contextMenu {
                            Button {
                                openLink(url: dataAirDict[key]!.refUrl)
                            } label: {
                                Text("btn_ref".localized)
                            }
                            Button {
                                openLink(url: dataAirDict[key]!.url)
                            } label: {
                                Text("btn_uadata".localized)
                            }
                        }
                }
            }, header: {
                Text("type_air".localized)
            })
            
            Section(content: {
                ForEach(dataWaterDict.keys.sorted(), id: \.self) { key in
                    Text("\(Text("item_\(key)".localized)): \(dataWaterDict[key]!.value)")
                        .contextMenu {
                            Button {
                                openLink(url: dataAirDict[key]!.refUrl)
                            } label: {
                                Text("btn_ref".localized)
                            }
                            Button {
                                openLink(url: dataAirDict[key]!.url)
                            } label: {
                                Text("btn_uadata".localized)
                            }
                        }
                }
            }, header: {
                Text("type_water".localized)
            })
        }
        .onAppear {
            loadData()
        }
    }
    
    private func openLink(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    private func loadData() {
        groundItems.forEach { key in
            UaDataAPI.getData(file: key) { data in
                dataGroundDict[key] = data
            }
        }
        airItems.forEach { key in
            UaDataAPI.getData(file: key) { data in
                dataAirDict[key] = data
            }
        }
        waterItems.forEach { key in
            UaDataAPI.getData(file: key) { data in
                dataWaterDict[key] = data
            }
        }
    }
}

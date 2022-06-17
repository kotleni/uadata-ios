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
                        openLink(url: "https://uk.wikipedia.org/wiki/%D0%A0%D0%BE%D1%81%D1%96%D0%B9%D1%81%D1%8C%D0%BA%D0%B5_%D0%B2%D1%82%D0%BE%D1%80%D0%B3%D0%BD%D0%B5%D0%BD%D0%BD%D1%8F_%D0%B2_%D0%A3%D0%BA%D1%80%D0%B0%D1%97%D0%BD%D1%83_%282022%28")
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
    
    @State private var isLoading: Bool = true
    @State private var dataGroundDict: Dictionary<String, Data> = Dictionary()
    @State private var dataAirDict: Dictionary<String, Data> = Dictionary()
    @State private var dataWaterDict: Dictionary<String, Data> = Dictionary()
    
    var body: some View {
        ZStack {
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
            .opacity(isLoading ? 0.0 : 1.0)
            .onAppear {
                loadData()
            }
            
            if isLoading {
                ProgressView()
            }
        }
    }
    
    private func openLink(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    private func loadData() {
        var score = 0
        let needScore = (groundItems.count + airItems.count + waterItems.count) - 1
        
        groundItems.forEach { key in
            UaDataAPI.getData(file: key) { data in
                dataGroundDict[key] = data
                if score >= needScore {
                    isLoading = false
                }
                score += 1
            }
        }
        airItems.forEach { key in
            UaDataAPI.getData(file: key) { data in
                dataAirDict[key] = data
                if score >= needScore {
                    isLoading = false
                }
                score += 1
            }
        }
        waterItems.forEach { key in
            UaDataAPI.getData(file: key) { data in
                dataWaterDict[key] = data
                if score >= needScore {
                    isLoading = false
                }
                score += 1
            }
        }
    }
}

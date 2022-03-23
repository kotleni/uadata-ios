import SwiftUI

struct ContentView: View {
    @State private var peoplesCount: Int = 0
    @State private var bbmCount: Int = 0
    @State private var planesCount: Int = 0
    @State private var tanksCount: Int = 0
    @State private var artileryCount: Int = 0
    @State private var rszvCount: Int = 0
    @State private var ppoCount: Int = 0
    @State private var helicoptersCount: Int = 0
    @State private var autoCount: Int = 0
    @State private var shipsCount: Int = 0
    @State private var pmmCount: Int = 0
    @State private var bplaCount: Int = 0
    
    var body: some View {
        VStack {
            Text("🇺🇦")
                .font(.system(size: 42.0))
                .padding()
            
            Form {
                Section(content: {
                    Text("Особовий склад: \(peoplesCount)")
                    Text("ББМ: \(bbmCount)")
                    Text("Танки: \(tanksCount)")
                    Text("Артилерійські системи: \(artileryCount)")
                    Text("РСЗВ: \(rszvCount)")
                    Text("ППО: \(ppoCount)")
                    Text("Автомобільна техніка: \(autoCount)")
                    Text("Цистерни ПММ: \(pmmCount)")
                }, header: { Text("Наземнi") })
                
                Section(content: {
                    Text("Літаки: \(planesCount)")
                    Text("Гелікоптери: \(helicoptersCount)")
                    Text("БПЛА: \(bplaCount)")
                }, header: { Text("Повітряні") })
                
                Section(content: {
                    Text("Кораблі: \(shipsCount)")
                }, header: { Text("Наводний") })
            }
        }
            .onAppear(perform: onStart)
    }
    
    private func onStart() {
        UaDataAPI.getPeoples { count in peoplesCount = count }
        UaDataAPI.getBBM { count in bbmCount = count }
        UaDataAPI.getPlanes { count in planesCount = count }
        UaDataAPI.getTanks { count in tanksCount = count }
        UaDataAPI.getArtilery { count in artileryCount = count }
        UaDataAPI.getRSZV { count in rszvCount = count }
        UaDataAPI.getPPO { count in ppoCount = count }
        UaDataAPI.getHelicopters { count in helicoptersCount = count }
        UaDataAPI.getAuto { count in autoCount = count }
        UaDataAPI.getShips { count in shipsCount = count }
        UaDataAPI.getPMM { count in pmmCount = count }
        UaDataAPI.getBPLA { count in bplaCount = count }
    }
}



//
//  EditDestinationView.swift
//  MyTour
//
//  Created by André Porto on 01/11/23.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    
    @Bindable var destination: Destination
    
    var body: some View {
        Form {
            TextField("Nome", text: $destination.name)
            TextField("Detalhes", text: $destination.details, axis: .vertical)
            DatePicker("Data", selection: $destination.date)
            
            Section("Prioridade") {
                Picker("Prioridade", selection: $destination.priority) {
                    Text("Não").tag(1)
                    Text("Talvez").tag(2)
                    Text("Sim").tag(3)
                }
                .pickerStyle(.segmented)
            }
        }
        .navigationTitle("Editar Destino")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Destino de Exemplo", details: "Exemplo e detalhes aparecerão aqui e irão expandir verticalmente automaticamente enquanto são editados.")
        return EditDestinationView(destination: example)
            .modelContainer(container)
    } catch {
        fatalError("Falha ao criar o model container.")
    }
}

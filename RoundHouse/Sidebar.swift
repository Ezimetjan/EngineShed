//
//  Sidebar.swift
//  RoundHouse
//
//  Created by Scott James Remnant on 6/22/20.
//

import SwiftUI

struct Sidebar: View {
    enum NavigationItem {
        case purchases
        case trains
    }

    @State var selection: Set<NavigationItem> = [.trains]

    var body: some View {
        List(selection: $selection) {
            NavigationLink(
                destination: PurchasesView()) {
                Label("Purchases", systemImage: "bag")
            }
            .accessibility(label: Text("Purchases"))
            .tag(NavigationItem.purchases)

            NavigationLink(
                destination: TrainsView()) {
                Label("Trains", systemImage: "tram.fill")
            }
            .accessibility(label: Text("Trains"))
            .tag(NavigationItem.trains)
        }
        .listStyle(SidebarListStyle())
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}

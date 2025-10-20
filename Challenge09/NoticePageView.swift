//
//  NoticePageView.swift
//  Challenge09
//
//  Created by Ana Clara Ferreira Caldeira on 20/10/25.
//

import SwiftUI


struct NoticePageView: View {
	@Environment(\.modelContext) var modelContext
	
	var notice: NoticeClass
	
    var body: some View {
		NavigationStack {
			ScrollView(showsIndicators: false) {
				VStack(alignment: .leading, spacing: 15) {
					Text(notice.title)
						.font(.title.bold())
						.foregroundStyle(.primary)
					
					GeometryReader { geometry in
						JustifiedTextView(text: notice.nDescription)
							.frame(width: geometry.size.width)
					}
   }
   .frame(height: 800)
				}
				.padding()
			}
		}
    }


#Preview {
	NoticePageView(notice: NoticeClass(title: "Tile", nDescription: "Description"))
}

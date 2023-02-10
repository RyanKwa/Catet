//
//  CatGalleryView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 22/07/22.
//

import SwiftUI

struct CatGalleryView: View {
    let columns = [
        GridItem(.flexible(minimum: 100),spacing: nil, alignment: nil),
        GridItem(.flexible(minimum: 100),spacing: nil, alignment: nil),
        GridItem(.flexible(minimum: 100),spacing: nil, alignment: nil)
    ]
    @StateObject var catGalleryVM = CatGalleryViewModel()
    var body: some View {
        
        NavigationView {
            ScrollView {
                if catGalleryVM.catGalleryData.count == 0 {
                    EmptyStateView(emptyStateFor: .catGallery)
                        .navigationBarTitle("Cat Gallery", displayMode: .large).navigationBarHidden(false)
                }
                else {
                    LazyVGrid(columns: columns,spacing: 30){
                        ForEach(catGalleryVM.catGalleryData, id:\.self){ cat in
                            CatDisplayView(catGalleryData: cat,imageLoader: ImageLoader(url: cat.wrappedURL)).navigationBarTitle("Cat Gallery", displayMode: .large).navigationBarHidden(false)
                        }
                    }
                }
            }
            .padding()
            .onAppear{
                catGalleryVM.fetchCatGallery()
                
            }
        }
        
    }
}

struct CatGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        CatGalleryView()
    }
}

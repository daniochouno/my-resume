//
//  PDFViewerView.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 1/6/23.
//

import SwiftUI
import PDFKit

struct PDFViewerView: View {
    let pdfDocument: PDFDocument
    private let pdfUrl: URL
    
    init() {
        let pdfFilename = String(localized: "pdfViewer.resume.filename")
        self.pdfUrl = Bundle.main.url(forResource: pdfFilename, withExtension: "pdf")!
        self.pdfDocument = PDFDocument(url: pdfUrl)!
    }
    
    var body: some View {
        ZStack {
            PDFKitView(pdfDocument: pdfDocument)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView()
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                PrimaryButtonView(title: "pdfViewer.resume.download") {
                    share(items: [self.pdfUrl])
                }
            }
        }
        .onAppear {
            UINavigationBar.appearance().barTintColor = UIColor(named: "BackgroundColor") ?? .white
        }
    }
    
    @discardableResult
    func share(
        items: [Any],
        excludedActivityTypes: [UIActivity.ActivityType]? = nil
    ) -> Bool {
        guard let source =
                UIApplication.shared.keyWindow?.rootViewController else {
            return false
        }
        let vc = UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )
        vc.excludedActivityTypes = excludedActivityTypes
        vc.popoverPresentationController?.sourceView = source.view
        source.present(vc, animated: true)
        return true
    }
}

private struct PDFKitView: UIViewRepresentable {
    let pdfDocument: PDFDocument
    
    init(pdfDocument: PDFDocument) {
        self.pdfDocument = pdfDocument
    }
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.backgroundColor = UIColor(named: "BackgroundColor") ?? .white
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = pdfDocument
    }
}

struct PDFViewerView_Previews: PreviewProvider {
    static var previews: some View {
        PDFViewerView()
    }
}

//
//  WorkDetailsViewModel.swift
//  myResume
//
//  Created by Daniel Martínez Muñoz on 16/5/23.
//

import Foundation

final class WorkDetailsViewModel: ObservableObject {
    private let id: String
    private let fetchWorkDetailsUseCase: FetchWorkDetailsUseCase
    
    @Published var isLoading = true
    @Published var workDetails: WorkDetailsModel?
    @Published var dataLoadedOrigin: String?
    @Published var errorMessage: String?
    
    init(id: String, fetchWorkDetailsUseCase: FetchWorkDetailsUseCase) {
        self.id = id
        self.fetchWorkDetailsUseCase = fetchWorkDetailsUseCase
    }
    
    @MainActor
    func load() async {
        self.isLoading = true
        let result = await fetchWorkDetailsUseCase.fetch(id: id)
        switch result {
        case .success(let workDetailsUseCaseModel):
            self.dataLoadedOrigin = "data.origin.\(workDetailsUseCaseModel.type.rawValue)"
            self.workDetails = WorkDetailsModel(from: workDetailsUseCaseModel.item)
        case .failure(let error):
            self.errorMessage = "\(error)"
        }
        self.isLoading = false
    }
    
    func getTimelapseCount() -> (Int, Int)? {
        guard let workDetails else { return nil }
        let endDate = workDetails.endDate ?? Date()
        let endDateWithLastDayOfMonth = getLastDayOfMonth(from: endDate)
        let startDate = workDetails.startDate
        let startDateWithFirstDayOfMonth = getFirstDayOfMonth(from: startDate)
        let years = Calendar.current.dateComponents([.year], from: startDateWithFirstDayOfMonth, to: endDateWithLastDayOfMonth).year ?? 0
        let months = Calendar.current.dateComponents([.month], from: startDateWithFirstDayOfMonth, to: endDateWithLastDayOfMonth).month ?? 0
        let _months = months - (years * 12) + 1
        return (years, _months)
    }
    
    private func getFirstDayOfMonth(from date: Date) -> Date {
        guard let firstDay = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: date))) else { return date }
        return firstDay
    }
    
    private func getLastDayOfMonth(from date: Date) -> Date {
        let firstDay = getFirstDayOfMonth(from: date)
        guard let lastDay = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: firstDay) else { return date }
        return lastDay
    }
}

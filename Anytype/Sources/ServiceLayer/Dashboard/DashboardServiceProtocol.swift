import AnytypeCore

protocol DashboardServiceProtocol {
    
    func createNewPage(isDraft: Bool) -> AnytypeId?
    
}

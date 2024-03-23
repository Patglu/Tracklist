import SwiftUI
import RealmSwift
import Combine

protocol RealmManagable{
    func save(for item: AlbumDetail)
    func remove(id: String)
}

class RealmManager: ObservableObject, RealmManagable{
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var savedAlbums: [DBAlbumInfo] = []
    private var token: NotificationToken?
    private let realmService = RealmService()
    
    init() {
        fetchObjects()
        setupObserver()
    }
    deinit {
        token?.invalidate()
    }
    
    private func fetchObjects() {
        realmService.get(DBAlbumInfo.self)
            .sink(receiveCompletion: { _ in }) { [weak self] objects in
                self?.savedAlbums = objects
            }
            .store(in: &cancellables)
    }
    //
    //    func updateTitle(_ item: DBAlbumInfo, newTitle: String, with block: @escaping () -> Void) {
    //        realmService.update(id: item.id.stringValue, newTitle: newTitle) {
    //            block()
    //        }
    //        .sink(receiveCompletion: { _ in }) { [weak self] _ in
    //            self?.fetchObjects()
    //        }
    //        .store(in: &cancellables)
    //    }
    
    func save(for item: AlbumDetail){
        let newItem = DBAlbumInfo()
        newItem.albumTitle = item.title
        newItem.albumUrl = item.coverImageUrl
        newItem.artistTitle = item.artist
        newItem.dateSaved = Date.now
        
        realmService.add(newItem)
            .sink(receiveCompletion: { _ in }) { _ in
            }
            .store(in: &cancellables)
        
        //Save to realm
        //        let realm = try! Realm()
        //
        //        try? realm.write{
        //            realm.add(newItem)
        //            viewModel.clearFields()
        //            UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
        //        }
    }
    
    func remove(id: String) {
        realmService.delete(id)
            .sink(receiveCompletion: { _ in }) { _ in
                
            }
            .store(in: &cancellables)
    }
    
    private func setupObserver() {
        do {
            let realm = try Realm()
            let results = realm.objects(DBAlbumInfo.self)
            token = results.observe({ [weak self] changes in
                self?.savedAlbums = results.map(DBAlbumInfo.init)
            })
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

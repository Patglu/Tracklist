import RealmSwift
import Foundation
import Combine

class RealmService: ObservableObject, RealmRepository {
    typealias T = DBAlbumInfo
    private var realm: Realm
    
    init() {
        do {
            let config = Realm.Configuration(schemaVersion: 2)
            Realm.Configuration.defaultConfiguration = config
            self.realm = try Realm()
        } catch {
            fatalError("Error initializing Realm: \(error)")
        }
    }
    
    func add<T: Object>(_ object: T) -> AnyPublisher<Void, Error> where T: Identifiable {
        return Future<Void, Error> { [weak self] promise in
            guard let self = self else { return }

            do {
                let existingObjects = self.realm.objects(T.self).filter("id == %@", object.id)

                try self.realm.write {
                    if existingObjects.isEmpty {
                        self.realm.add(object)
                        promise(.success(()))
                    } else {
                        let errorTemp = NSError(domain: "", code: 400)
                        promise(.failure(errorTemp))
                    }
                }
                
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func get<T: Object>(_ objectType: T.Type) -> AnyPublisher<[T], Error> {
        return Future<[T], Error> { promise in
            let results = self.realm.objects(objectType)
            let objects = Array(results)
            promise(.success(objects))
        }.eraseToAnyPublisher()
    }
    
    func update(id: String,newTitle: String, with block: @escaping () -> Void) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            do {
                let objectId = try ObjectId(string: id)
                let clothing = self.realm.object(ofType: DBAlbumInfo.self, forPrimaryKey: objectId)
                try self.realm.write {
//                    clothing?.itemDescription = newTitle
                    block()
                }
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    func delete(_ id: String) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            do {
                let objectId = try ObjectId(string: id)
                if let clothing = self.realm.object(ofType: DBAlbumInfo.self, forPrimaryKey: objectId) {
                    try self.realm.write {
                        self.realm.delete(clothing)
                    }
                }
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}

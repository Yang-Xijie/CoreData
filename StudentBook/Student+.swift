// Student+.swift

import CoreData
import Foundation

extension Student {
    // MARK: - request to get data from Core Data

    static var request_allStudent: NSFetchRequest<Student> {
        let request = NSFetchRequest<Student>(entityName: "Student")
        request.sortDescriptors = [NSSortDescriptor(key: "ident_", ascending: true)]
        return request
    }

    // MARK: - deal with data in Core Data

    var ident: Int {
        get { Int(ident_) }
        set { ident_ = Int32(newValue) }
    }

    var name: String {
        get { name_! }
        set { name_ = newValue }
    }

    var email: String? {
        get { email_ }
        set { email_ = newValue }
    }
}

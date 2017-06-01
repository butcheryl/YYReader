//
//  Database.swift
//  YYReader
//
//  Created by butcheryl on 2017/6/1.
//  Copyright © 2017年 butcheryl. All rights reserved.
//

import SQLite

class Database {
    fileprivate let db = try? Connection()
    
    fileprivate let books = Table("books")
    
    fileprivate let chapters = Table("chapters")
 
    init() {
        createBooksTable()
        createChaptersTable()
    }
    
    func createBooksTable() {
        let id = Expression<Int>("id")
        let uri = Expression<String>("uri")
        let name = Expression<String>("name")
        let author = Expression<String?>("author")
        let category = Expression<String?>("category")
        let cover = Expression<String?>("cover")
        let desc = Expression<String?>("desc")
        let currentReadBookId = Expression<Int>("reading_index")
        
        _ = try? db?.run(books.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(uri)
            t.column(name)
            t.column(author)
            t.column(category)
            t.column(cover)
            t.column(desc)
            t.column(currentReadBookId)
        })
    }
    
    func createChaptersTable() {
        let id = Expression<Int>("id")
        let number = Expression<Int>("number")
        let title = Expression<String>("title")
        let content = Expression<String?>("content")
        let bookId = Expression<Int>("book_id")
        
        _ = try? db?.run(chapters.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(bookId)
            t.column(number)
            t.column(title)
            t.column(content)
            t.foreignKey(bookId, references: books, id, delete: .setNull)
        })
    }
    
    func bookList() -> [Book] {
        guard let db = db else { return [] }
        
        guard let rows = try? db.prepare(books) else { return [] }
        
        return rows.map({ _ in Book() })
    }
    
    
    
    func book(where expression: Expression<Bool>) -> Book? {
        guard let db = db else { return nil }
        
        guard let row = try? db.pluck(books.filter(expression))! else { return nil }
        
        let bookID = row[Expression<Int>("id")]
        
        let query = chapters.where(Expression<Int>("book_id") == bookID).order(Expression<Int>("id").desc)
        
        guard let c = try? db.prepare(query) else { return nil }
        
        var book = Book()
        
        book.id = bookID
        book.uri = row.get(Expression<String>("uri"))
        book.name = row.get(Expression<String>("name"))
        book.author = row.get(Expression<String?>("author"))
        book.category = row.get(Expression<String?>("category"))
        book.cover = row.get(Expression<String?>("cover"))
        book.desc = row.get(Expression<String?>("desc"))
        book.currentReadBookId = row.get(Expression<Int>("reading_index"))
        
        book.chapters = c.map {
            Chapter(id: $0.get(Expression<Int>("id")),
                    number: $0.get(Expression<Int>("number")),
                    title: $0.get(Expression<String>("title")),
                    paragraphs: [],
                    hasCache: true)
        }
        
        return book
    }
    
    func book(where uri: String) -> Book? {
        return book(where: Expression<String>("uri") == uri)
    }
    
    func book(where id: Int) -> Book? {
        return book(where: Expression<Int>("id") == id)
    }
}

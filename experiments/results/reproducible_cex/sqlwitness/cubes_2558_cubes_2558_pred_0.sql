-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO book (book_id, title, issues, writer) VALUES (0, 'default2', 0.0, 'default2'), (1, NULL, 1.0, NULL), (2, NULL, 1.0, 'default2'), (3, 'default2', NULL, 'Elaine Lee'), (4, 'default1', 0.0, 'default2'), (5, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "book" WHERE ("writer" <> 'Elaine Lee') ORDER BY title, book.book_id NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Title FROM book WHERE Writer <> 'Elaine Lee';

/*
Prediction Result:
('default2',)
(None,)
('default1',)
*/
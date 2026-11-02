-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO book (book_id, title, issues, writer) VALUES (1, NULL, 0.0, 'default1'), (0, NULL, 1.0, NULL), (2, 'default2', 0.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM book ORDER BY title, book.book_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('default2',)
*/

-- Prediction Query
SELECT Title FROM book ORDER BY Issues ASC, book.book_id NULLS LAST;

/*
Prediction Result:
(None,)
('default2',)
(None,)
*/
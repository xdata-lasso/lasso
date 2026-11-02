-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO book (book_id, title, issues, writer) VALUES (0, NULL, NULL, NULL), (1, NULL, 2.0, NULL), (2, 'default2', 0.0, 'default1'), (3, 'default1', 2.0, 'default2'), (4, 'default2', NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT * FROM book AS LHS WHERE NOT EXISTS(SELECT 1 FROM publication AS RHS WHERE (LHS.book_id = RHS.book_id))) ORDER BY title;

/*
Gold Result:
(None,)
(None,)
('default1',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Title FROM book WHERE NOT Book_ID IN (SELECT Book_ID FROM publication);

/*
Prediction Result:
(None,)
(None,)
('default2',)
('default1',)
('default2',)
*/
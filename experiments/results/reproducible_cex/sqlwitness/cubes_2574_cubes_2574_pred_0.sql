-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO book (book_id, title, issues, writer) VALUES (0, 'default1', 0.0, 'default1'), (1, 'default2', 1.0, 'default1'), (2, NULL, NULL, 'default1'), (3, NULL, NULL, NULL);
INSERT INTO publication (publication_id, book_id, publisher, publication_date, price) VALUES (1, 2, 'default2', 'default2', 1.0), (0, 0, 'default1', 'default2', 1.0), (2, 3, 'default1', 'default1', NULL), (3, 1, NULL, NULL, NULL), (4, 2, 'default2', 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publication_date FROM publication ORDER BY publication_date, publication.publication_id NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
('default2',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Publication_Date FROM publication ORDER BY Price DESC, publication.publication_id NULLS LAST;

/*
Prediction Result:
('default2',)
('default2',)
('default1',)
(None,)
('default2',)
*/
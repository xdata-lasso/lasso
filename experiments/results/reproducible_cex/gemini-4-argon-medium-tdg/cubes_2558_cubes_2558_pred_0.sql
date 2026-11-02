-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (10, 'The Invisibles', 59.0, 'Grant Morrison');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (5, 'The Invisibles', 1.0, 'Grant Morrison');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (8, 'Swamp Thing', 64.0, 'Alan Moore');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (12, NULL, 5.0, 'Frank Miller');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "book" WHERE ("writer" <> 'Elaine Lee') ORDER BY title, book.book_id NULLS LAST;

/*
Gold Result:
(None,)
('Swamp Thing',)
('The Invisibles',)
('The Invisibles',)
*/

-- Prediction Query
SELECT Title FROM book WHERE Writer <> 'Elaine Lee';

/*
Prediction Result:
('The Invisibles',)
('Swamp Thing',)
('The Invisibles',)
(None,)
*/
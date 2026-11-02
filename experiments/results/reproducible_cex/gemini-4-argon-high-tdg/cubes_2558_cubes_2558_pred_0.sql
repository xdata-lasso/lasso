-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (1, 'Zebra', 5.0, 'Alan Moore');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (2, 'Apple', 3.0, 'Elaine Lee');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (3, 'Mango', 4.0, 'Frank Miller');
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (1, 2, 'DC', '1985-01-01', 9.99);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (2, 3, 'Marvel', '1990-05-10', 14.99);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (3, 3, 'Dark Horse', '1992-08-15', 19.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "book" WHERE ("writer" <> 'Elaine Lee') ORDER BY title, book.book_id NULLS LAST;

/*
Gold Result:
('Mango',)
('Zebra',)
*/

-- Prediction Query
SELECT Title FROM book WHERE Writer <> 'Elaine Lee';

/*
Prediction Result:
('Zebra',)
('Mango',)
*/
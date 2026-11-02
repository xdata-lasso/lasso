-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1042, 'Legal secretary', 1043.5, 'blue');
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1046, 'Chief Strategy Officer', 1047.5, 'her');
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1050, 'Trade mark attorney', 1051.5, 'everything');
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (0, 1042, 'best', 'husband', 1045.5);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (150, 1046, 'throw', 'husband', 1049.5);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (20, 1050, 'surface', 'show', 1053.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publication_date FROM publication ORDER BY publication_date, publication.publication_id NULLS LAST;

/*
Gold Result:
('husband',)
('husband',)
('show',)
*/

-- Prediction Query
SELECT Publication_Date FROM publication ORDER BY Price DESC, publication.publication_id NULLS LAST;

/*
Prediction Result:
('show',)
('husband',)
('husband',)
*/
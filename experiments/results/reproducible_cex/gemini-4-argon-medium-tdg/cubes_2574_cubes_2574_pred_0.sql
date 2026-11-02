-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (10, 'Alpha', 3.0, 'Author X');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (20, 10, 'House A', NULL, 12.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (10, 10, 'House B', '2022-03-15', 18.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (30, NULL, 'House C', NULL, 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publication_date FROM publication ORDER BY publication_date, publication.publication_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('2022-03-15',)
*/

-- Prediction Query
SELECT Publication_Date FROM publication ORDER BY Price DESC, publication.publication_id NULLS LAST;

/*
Prediction Result:
(None,)
('2022-03-15',)
(None,)
*/
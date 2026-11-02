-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by publication_date ASC, duplicates retention (SELECT vs SELECT DISTINCT), and inner join vs single table query (nullable Book_ID).
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Database Systems', 1.0, 'C.J. Date');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'Operating Systems', 2.0, 'Silberschatz');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (30, 1, 'Pearson', '2022-05-01', 50.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (10, 2, 'Wiley', '2020-01-15', 40.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (20, NULL, 'Independent', '2020-01-15', 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publication_date FROM publication ORDER BY publication_date, publication.publication_id NULLS LAST;

/*
Gold Result:
('2020-01-15',)
('2020-01-15',)
('2022-05-01',)
*/

-- Prediction Query
SELECT Publication_Date FROM publication ORDER BY Price DESC, publication.publication_id NULLS LAST;

/*
Prediction Result:
('2022-05-01',)
('2020-01-15',)
('2020-01-15',)
*/
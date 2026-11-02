-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'The Fall', 1.0, 'Albert Camus');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'The Plague', 2.0, 'Albert Camus');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (10, 1, 'Penguin', '2022-05-01', 15.5);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (20, 1, 'Penguin', '2018-01-15', 25.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (30, 2, 'Vintage', '2020-11-30', 10.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (5, 2, 'Vintage', '2018-01-15', 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publication_date FROM publication ORDER BY publication_date, publication.publication_id NULLS LAST;

/*
Gold Result:
('2018-01-15',)
('2018-01-15',)
('2020-11-30',)
('2022-05-01',)
*/

-- Prediction Query
SELECT Publication_Date FROM publication ORDER BY Price DESC, publication.publication_id NULLS LAST;

/*
Prediction Result:
('2018-01-15',)
('2018-01-15',)
('2022-05-01',)
('2020-11-30',)
*/
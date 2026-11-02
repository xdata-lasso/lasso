-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (1, 1989, 'A1', 'T1', 'P_1989', 'C1', 'R1');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (2, 1990, 'A2', 'T2', 'P_Zebra', 'C2', 'R2');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (3, 1990, 'A3', 'T3', 'P_Alpha', 'C3', 'R3');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (4, 1991, 'A4', 'T4', 'P_1991', 'C4', 'R4');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (5, NULL, 'A5', 'T5', 'P_NullYear', 'C5', 'R5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM book_club WHERE (YEAR <> 1989 AND YEAR = 1990) ORDER BY publisher, book_club.book_club_id NULLS LAST;

/*
Gold Result:
('P_Alpha',)
('P_Zebra',)
*/

-- Prediction Query
SELECT publisher FROM book_club WHERE YEAR = 1989 INTERSECT SELECT publisher FROM book_club WHERE YEAR = 1990;

/*
Prediction Result:
*/
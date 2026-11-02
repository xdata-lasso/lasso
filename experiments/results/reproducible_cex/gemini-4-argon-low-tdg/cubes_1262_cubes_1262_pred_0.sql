-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Year ASC, tie-breaking by book_club_id ASC, and inverse correlation between book_club_id and Book_Title/Publisher to catch wrong tie-breaker columns.
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (10, 1995, 'Author Z', 'Zeta Book', 'Zeta Pub', 'Fiction', 'Nominated');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (2, 1995, 'Author A', 'Omega Book', 'Omega Pub', 'Non-Fiction', 'Winner');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (5, 1990, 'Author M', 'Alpha Book', 'Alpha Pub', 'Poetry', 'Winner');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (1, 2000, 'Author B', 'Beta Book', 'Beta Pub', 'History', 'Shortlisted');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT YEAR, book_title, publisher FROM book_club ORDER BY YEAR, book_club.book_club_id NULLS LAST;

/*
Gold Result:
(1990, 'Alpha Book', 'Alpha Pub')
(1995, 'Omega Book', 'Omega Pub')
(1995, 'Zeta Book', 'Zeta Pub')
(2000, 'Beta Book', 'Beta Pub')
*/

-- Prediction Query
SELECT YEAR, book_title, publisher FROM book_club ORDER BY YEAR DESC, book_club.book_club_id NULLS LAST;

/*
Prediction Result:
(2000, 'Beta Book', 'Beta Pub')
(1995, 'Omega Book', 'Omega Pub')
(1995, 'Zeta Book', 'Zeta Pub')
(1990, 'Alpha Book', 'Alpha Pub')
*/
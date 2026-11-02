-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (1, 2000, 'Author A', 'Title A', 'Pub A', 'Cat A', 'Res A');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (2, 2001, 'Author B', 'Title B', 'Pub B', 'Cat B', 'Res B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT YEAR, book_title, publisher FROM book_club ORDER BY YEAR, book_club.book_club_id NULLS LAST;

/*
Gold Result:
(2000, 'Title A', 'Pub A')
(2001, 'Title B', 'Pub B')
*/

-- Prediction Query
SELECT YEAR, book_title, publisher FROM book_club ORDER BY YEAR DESC, book_club.book_club_id NULLS LAST;

/*
Prediction Result:
(2001, 'Title B', 'Pub B')
(2000, 'Title A', 'Pub A')
*/
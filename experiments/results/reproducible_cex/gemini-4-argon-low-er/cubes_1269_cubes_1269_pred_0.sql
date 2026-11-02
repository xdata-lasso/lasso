-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (1, 2020, 'Author A', 'Title A', 'Pub A', 'Fiction', 'Nominee');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (2, 2021, 'Author B', 'Title B', 'Pub B', 'Fiction', 'Winner');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, n AS count___ FROM (SELECT category, YEAR, COUNT(*) AS n FROM book_club GROUP BY category, YEAR) ORDER BY category, count___ NULLS LAST;

/*
Gold Result:
('Fiction', 1)
('Fiction', 1)
*/

-- Prediction Query
SELECT category, COUNT(*) FROM book_club GROUP BY category;

/*
Prediction Result:
('Fiction', 2)
*/
-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (1, 'A', 2020, 'Director 1', 20.0, 100);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (2, 'B', 2021, 'Director 2', 10.0, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, YEAR, director FROM movie ORDER BY title, movie.movie_id NULLS LAST;

/*
Gold Result:
('A', 2020, 'Director 1')
('B', 2021, 'Director 2')
*/

-- Prediction Query
SELECT title, YEAR, director FROM movie ORDER BY budget_million, movie.movie_id NULLS LAST;

/*
Prediction Result:
('B', 2021, 'Director 2')
('A', 2020, 'Director 1')
*/
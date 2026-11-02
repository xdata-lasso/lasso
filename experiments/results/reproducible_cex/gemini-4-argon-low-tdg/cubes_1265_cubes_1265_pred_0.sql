-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests YEAR boundary conditions (1998, 1999, 2000, 2001) and NULL YEAR handling.
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (1, 'Movie 1998', 1998, 'Director A', 10.0, 100000);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (2, 'Movie 1999', 1999, 'Director B', 20.0, 200000);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (3, 'Movie 2000', 2000, 'Director C', 30.0, 300000);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (4, 'Movie 2001', 2001, 'Director D', 40.0, 400000);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (5, 'Movie NULL Year', NULL, 'Director E', 50.0, 500000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director FROM movie WHERE (YEAR < 1999 OR YEAR <= 2000) ORDER BY director, movie.movie_id NULLS LAST;

/*
Gold Result:
('Director A',)
('Director B',)
('Director C',)
*/

-- Prediction Query
SELECT director FROM movie WHERE YEAR = 1999 OR YEAR = 2000;

/*
Prediction Result:
('Director B',)
('Director C',)
*/
-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Title, tie-breaking by movie_id, and ensures DISTINCT/GROUP BY mutants fail by having duplicate (Title, Year, Director) tuples with different movie_ids.
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (10, 'Zorro', 1998, 'Martin Campbell', 95.0, 250000000);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (20, 'Avatar', 2009, 'James Cameron', 237.0, 2847000000);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (5, 'Avatar', 2009, 'James Cameron', 237.0, 2847000000);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (15, 'Avatar', 2022, 'James Cameron', 350.0, 2320000000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, YEAR, director FROM movie ORDER BY title, movie.movie_id NULLS LAST;

/*
Gold Result:
('Avatar', 2009, 'James Cameron')
('Avatar', 2022, 'James Cameron')
('Avatar', 2009, 'James Cameron')
('Zorro', 1998, 'Martin Campbell')
*/

-- Prediction Query
SELECT title, YEAR, director FROM movie ORDER BY budget_million, movie.movie_id NULLS LAST;

/*
Prediction Result:
('Zorro', 1998, 'Martin Campbell')
('Avatar', 2009, 'James Cameron')
('Avatar', 2009, 'James Cameron')
('Avatar', 2022, 'James Cameron')
*/
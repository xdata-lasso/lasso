-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Title (ASC), secondary ordering by movie_id (ASC) when Titles are identical,
-- and catches mutants that falsely apply DISTINCT (identical Title, Year, Director with different movie_id).
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (10, 'Avatar', 2009, 'James Cameron', 237.0, 2847246203);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (2, 'Avatar', 2009, 'James Cameron', 237.0, 2847246203);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (5, 'Avatar', 2022, 'James Cameron', 350.0, 2320250281);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (1, 'Batman', 1989, 'Tim Burton', 35.0, 411348924);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (3, 'Arrival', 2016, 'Denis Villeneuve', 47.0, 203388186);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, YEAR, director FROM movie ORDER BY title, movie.movie_id NULLS LAST;

/*
Gold Result:
('Arrival', 2016, 'Denis Villeneuve')
('Avatar', 2009, 'James Cameron')
('Avatar', 2022, 'James Cameron')
('Avatar', 2009, 'James Cameron')
('Batman', 1989, 'Tim Burton')
*/

-- Prediction Query
SELECT title, YEAR, director FROM movie ORDER BY budget_million, movie.movie_id NULLS LAST;

/*
Prediction Result:
('Batman', 1989, 'Tim Burton')
('Arrival', 2016, 'Denis Villeneuve')
('Avatar', 2009, 'James Cameron')
('Avatar', 2009, 'James Cameron')
('Avatar', 2022, 'James Cameron')
*/
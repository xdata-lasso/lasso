-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests when MAX(gross_worldwide) > 2000, multiple rows tie for MAX, NULL gross_worldwide, and NULL director ordering (NULLS LAST).
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (1, 'Avatar', 2009, 'James Cameron', 237.0, 2500);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (2, 'Avatar', 2009, NULL, 237.0, 2500);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (3, 'Titanic', 1997, 'James Cameron', 200.0, 2500);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (4, 'Inception', 2010, 'Christopher Nolan', 160.0, 2000);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (5, 'Memento', 2000, 'Christopher Nolan', 9.0, 40);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (6, 'Unknown', 2020, 'Some Director', 1.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, director FROM (SELECT movie_id, title, YEAR, director, budget_million, gross_worldwide, MAX(gross_worldwide) OVER () AS maxgross_worldwide FROM movie) WHERE (maxgross_worldwide <= 2000 OR maxgross_worldwide = gross_worldwide) ORDER BY title, director NULLS LAST;

/*
Gold Result:
('Avatar', 'James Cameron')
('Avatar', None)
('Titanic', 'James Cameron')
*/

-- Prediction Query
SELECT title, director FROM movie WHERE YEAR <= 2000 ORDER BY gross_worldwide DESC, movie.movie_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Titanic', 'James Cameron')
*/
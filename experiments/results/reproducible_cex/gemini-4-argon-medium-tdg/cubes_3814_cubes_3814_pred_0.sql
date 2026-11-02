-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (1, 'Blockbuster', 2020, 'Nolan', 200.0, 2001);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (2, 'Blockbuster', 2021, NULL, 150.0, 2001);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (3, 'Blockbuster', 2019, 'Abrams', 180.0, 2001);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (4, 'Indie Film', 2018, 'Smith', 5.0, 2000);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (5, 'Unknown Gross', 2022, 'Doe', 10.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, director FROM (SELECT movie_id, title, YEAR, director, budget_million, gross_worldwide, MAX(gross_worldwide) OVER () AS maxgross_worldwide FROM movie) WHERE (maxgross_worldwide <= 2000 OR maxgross_worldwide = gross_worldwide) ORDER BY title, director NULLS LAST;

/*
Gold Result:
('Blockbuster', 'Abrams')
('Blockbuster', 'Nolan')
('Blockbuster', None)
*/

-- Prediction Query
SELECT title, director FROM movie WHERE YEAR <= 2000 ORDER BY gross_worldwide DESC, movie.movie_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/
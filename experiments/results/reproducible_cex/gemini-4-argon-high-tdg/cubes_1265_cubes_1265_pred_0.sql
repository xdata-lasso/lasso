-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (1, 'Future World', 2001, 'Zemeckis', 100.0, 500000000);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (2, 'Millennium Bug', 2000, 'Scorsese', 80.5, 300000000);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (3, 'Party 1999', 1999, 'Kubrick', 40.0, 150000000);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (4, 'Prehistoric', 1998, 'Anderson', 25.0, 90000000);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (5, 'Classic Era', 1985, 'Fincher', 15.0, 60000000);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (6, 'Unknown Date', NULL, 'Tarantino', 50.0, 200000000);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (7, 'Way Ahead', 2010, 'Bong', 60.0, 400000000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director FROM movie WHERE (YEAR < 1999 OR YEAR <= 2000) ORDER BY director, movie.movie_id NULLS LAST;

/*
Gold Result:
('Anderson',)
('Fincher',)
('Kubrick',)
('Scorsese',)
*/

-- Prediction Query
SELECT director FROM movie WHERE YEAR = 1999 OR YEAR = 2000;

/*
Prediction Result:
('Scorsese',)
('Kubrick',)
*/
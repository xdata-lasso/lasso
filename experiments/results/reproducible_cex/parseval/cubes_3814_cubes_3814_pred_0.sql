-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: movie --
INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (1, 'mov_c7796d', 1, 'mov_067748', 1.0, 2);

INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (-2147483647, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 483.665643, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, director FROM (SELECT movie_id, title, YEAR, director, budget_million, gross_worldwide, MAX(gross_worldwide) OVER () AS maxgross_worldwide FROM movie) WHERE (maxgross_worldwide <= 2000 OR maxgross_worldwide = gross_worldwide) ORDER BY title, director NULLS LAST;

/*
Gold Result:
('5k5swwqcgs', '8c4pgu7vfe')
('mov_c7796d', 'mov_067748')
*/

-- Prediction Query
SELECT title, director FROM movie WHERE YEAR <= 2000 ORDER BY gross_worldwide DESC, movie.movie_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('mov_c7796d', 'mov_067748')
*/
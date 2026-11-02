-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: movie --
INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (1, '5k5swwqcgs', 0, 'mov_ce23b5', 171.746906, 247012447);

INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (3, '8c4pgu7vfe', 0, 'mov_ce23b5', 483.665643, -1633151678);

INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (2, '5k5swwqcgs', 1999, '9n8', 874.871895, -106629402);

INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (4, 'u7', 2001, 'fe4hri', 710.998147, 1914020640);

INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (5, 'ypuzhsrw', NULL, 'b', 749.826493, 13244799);

INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (6, 'hvdltt', NULL, 'lbn', 240.969194, 462974032);

INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (7, 'posiie5unw6k', NULL, 'fa9', 877.276439, 546571701);

INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (8, '0t5c4ecigc', NULL, 'e376nium52', 816.814398, -443340271);

INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (9, 'uo4nrqrofqy', NULL, '5s5b', 22.720462, 2107872094);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director FROM movie WHERE (YEAR < 1999 OR YEAR <= 2000) ORDER BY director, movie.movie_id NULLS LAST;

/*
Gold Result:
('9n8',)
('mov_ce23b5',)
('mov_ce23b5',)
*/

-- Prediction Query
SELECT director FROM movie WHERE YEAR = 1999 OR YEAR = 2000;

/*
Prediction Result:
('9n8',)
*/
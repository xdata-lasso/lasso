-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (8, 19, '19', '19', '19', '19', '19');
INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (7, 19, '19', '19', '19', '19', '19');
INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (10, NULL, -145, '19', NULL, NULL);
INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (9, '16', 2000, '19', 17, 18);
INSERT INTO "culture_company" ("company_name", "movie_id", "book_club_id", "type", "incorporated_in", "group_equity_shareholding") VALUES ('12', 9, 7, '19', '19', 19);
INSERT INTO "culture_company" ("company_name", "movie_id", "book_club_id", "type", "incorporated_in", "group_equity_shareholding") VALUES ('11', 9, 7, '19', '19', 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director FROM movie WHERE (YEAR < 1999 OR YEAR <= 2000) ORDER BY director, movie.movie_id NULLS LAST;

/*
Gold Result:
('19',)
('19',)
*/

-- Prediction Query
SELECT director FROM movie WHERE YEAR = 1999 OR YEAR = 2000;

/*
Prediction Result:
('19',)
*/
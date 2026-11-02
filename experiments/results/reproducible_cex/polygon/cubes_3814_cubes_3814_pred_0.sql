-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (8, -715, '-715', '-715', '-715', '-715', '-715');
INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (10, NULL, 142, NULL, 13, -715);
INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (9, NULL, -719, NULL, 14, -716);
INSERT INTO "culture_company" ("company_name", "movie_id", "book_club_id", "type", "incorporated_in", "group_equity_shareholding") VALUES ('12', 9, 8, '-715', '-715', -715);
INSERT INTO "culture_company" ("company_name", "movie_id", "book_club_id", "type", "incorporated_in", "group_equity_shareholding") VALUES ('11', 9, 8, '-715', '-715', -715);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, director FROM (SELECT movie_id, title, YEAR, director, budget_million, gross_worldwide, MAX(gross_worldwide) OVER () AS maxgross_worldwide FROM movie) WHERE (maxgross_worldwide <= 2000 OR maxgross_worldwide = gross_worldwide) ORDER BY title, director NULLS LAST;

/*
Gold Result:
(None, None)
(None, None)
*/

-- Prediction Query
SELECT title, director FROM movie WHERE YEAR <= 2000 ORDER BY gross_worldwide DESC, movie.movie_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None, None)
*/
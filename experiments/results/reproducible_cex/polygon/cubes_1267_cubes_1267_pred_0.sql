-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (8, 1990, '20', NULL, '13', '14', '15');
INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (7, -388, '20', NULL, NULL, NULL, NULL);
INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (10, '20', 20, '20', 20, 20);
INSERT INTO "movie" ("movie_id", "title", "year", "director", "budget_million", "gross_worldwide") VALUES (9, '20', 20, '20', 20, 20);
INSERT INTO "culture_company" ("company_name", "movie_id", "book_club_id", "type", "incorporated_in", "group_equity_shareholding") VALUES ('12', 9, 7, '20', '20', 20);
INSERT INTO "culture_company" ("company_name", "movie_id", "book_club_id", "type", "incorporated_in", "group_equity_shareholding") VALUES ('11', NULL, 7, '20', '20', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT book_title, author_or_editor FROM book_club WHERE (YEAR <> 1989) ORDER BY book_title, book_club.book_club_id NULLS LAST;

/*
Gold Result:
(None, '20')
(None, '20')
*/

-- Prediction Query
SELECT book_title, author_or_editor FROM book_club WHERE YEAR > 1989;

/*
Prediction Result:
(None, '20')
*/
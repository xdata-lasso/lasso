-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: book_club --
INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (1, 1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483647, 1, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (2, -1576219117, '5u', 'w6kl', 'a9', '00t5c4e', 'cigce376nium');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (3, 283598170, 'zbuo4nrq', 'rofqyp5s5b', 'p', '02eutliqa11r', 'ytoo3o9');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (4, -1666765085, '72klex14ji7z', 'au2dwy', 'q13py', '78d99r', 'jsl');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (5, -346339240, 'yp5qi2rk', '9v', 'x58pz', 'f8jegd2', 'vy9uxj4');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (6, -1612443122, 'd', 'lph2gn', 'q', 'nqcx5h', 'cprj');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (7, -841004020, 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (8, -658391922, 'q7x', '7', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (9, 1129658414, '1afgo', 'ri', 'tsj3ayxp1q4', '01jh3den', 'c68x8vacx');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (10, -1762140823, 'w1of77pz', '72ct', 'c', 'mfg62', '0v');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (11, 820970595, 'qdjpe1io2', '78507cvt', 'ptt', '6b', 'ou5z');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM (SELECT LHS.year AS YEAR, LHS.n AS n, RHS.author_or_editor AS author_or_editor, RHS.book_title AS book_title, RHS.publisher AS publisher, RHS.category AS category, RHS.result AS RESULT FROM (SELECT YEAR, COUNT(*) AS n FROM book_club GROUP BY YEAR) AS LHS INNER JOIN book_club AS RHS ON (LHS.year = RHS.year AND LHS.n = RHS.book_club_id)) ORDER BY publisher;

/*
Gold Result:
*/

-- Prediction Query
SELECT publisher FROM book_club GROUP BY publisher ORDER BY COUNT(*) DESC, publisher NULLS LAST LIMIT 1;

/*
Prediction Result:
('2fxa7ryfdrz',)
*/
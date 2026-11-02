-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: book_club --
INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (1, 1, 'boo_be6f4d', 'boo_11d9c0', '5k5swwqcgs', '9n8', '4');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (2, 1, 'boo_be6f4d', 'boo_11d9c0', 'gu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (3, 1, 'boo_be6f4d', 'boo_11d9c0', 'rwbbp6luhvd', 'tti', 'bnp');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (4, 1989, 'mdpos', 'ie5', 'nw6klf', 'a9000t5c4eci', 'gce376nium52');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (5, NULL, 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', 'l7');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (6, 1, 'klex14ji', NULL, '7zwau2dwyr', '13pyu', '8d99rljsl');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (7, 1, NULL, 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT book_title, author_or_editor FROM book_club WHERE (YEAR <> 1989) ORDER BY book_title, book_club.book_club_id NULLS LAST;

/*
Gold Result:
(None, 'klex14ji')
('b4yp5qi', None)
('boo_11d9c0', 'boo_be6f4d')
('boo_11d9c0', 'boo_be6f4d')
('boo_11d9c0', 'boo_be6f4d')
*/

-- Prediction Query
SELECT book_title, author_or_editor FROM book_club WHERE YEAR > 1989;

/*
Prediction Result:
*/
-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: book_club --
INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (1, 2, 'boo_01f946', 'boo_b21dd9', 'boo_68fd67', 'boo_e7fc33', 'boo_c91fe3');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483647, 2, 'boo_47cea3', 'boo_836194', 'boo_17b5d9', 'boo_53875c', 'boo_31987e');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (2, 0, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (3, 0, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 'mdpos');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483644, -1576219117, '5u', 'w6kl', 'a9', 'q_1_7a60f7', '00t5c4e');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483643, 1274489983, 'gce', '76nium52', 'zbuo4nrqrof', 'q_1_7a60f7', 'qyp5s5bbp0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category FROM (SELECT category, YEAR, COUNT(DISTINCT YEAR) AS n_distinct FROM (SELECT * FROM book_club WHERE (YEAR <> 1989 OR YEAR < 2)) GROUP BY category, YEAR) ORDER BY category;

/*
Gold Result:
('bnp',)
('boo_53875c',)
('boo_e7fc33',)
('gu7v',)
('q_1_7a60f7',)
('q_1_7a60f7',)
*/

-- Prediction Query
SELECT category FROM book_club WHERE YEAR > 1989 GROUP BY category HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/
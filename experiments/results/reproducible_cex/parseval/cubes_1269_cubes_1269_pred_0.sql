-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: book_club --
INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483648, 1, '5k5swwqcgs', '9n8', '4', 'boo_d5acc4', 'gu7v');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483647, 1, 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'boo_d5acc4', 'tti');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483646, 1, 'bnp', 'mdpos', 'ie5', 'boo_d5acc4', 'nw6klf');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483645, 1, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'boo_d5acc4', 'qyp5s5bbp0');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483644, 1, '2eutliqa11r', 'ytoo3o9', 'l7', 'boo_d5acc4', 'klex14ji');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483643, 1, '7zwau2dwyr', '13pyu', '8d99rljsl', 'boo_d5acc4', 'b4yp5qi');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483642, NULL, 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'boo_d5acc4', 'wb');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483641, NULL, 'v', 'ph2', 'nd', 'boo_d5acc4', 'wnqcx');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483640, NULL, '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'boo_d5acc4', 'ozk3zbily');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483639, 1, 'kn6vc', '6ah', 'f8jswwl', NULL, '7xb72');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483638, 1, 'xa', '7ryfdrz16n', 'jja', NULL, '5dh');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483637, 1, 'ogrgjd8y', 't1afgog', 'itsj3', NULL, 'y');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483636, 1, 'p1q430', 'jh3den8', 'c68x8vacx7', 'boo_d5acc4', 'f');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483635, 1, '5w1of7', 'pzo72ctdc', 'mfg62', 'boo_d5acc4', '0v');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483634, 1, 'q8qdjpe1', 'o22', '8507cvtjp', 'boo_d5acc4', 'ttg6bnou5zi3');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483633, 1, 'c4bfkfoac', '0', '7z2zezjo7wg', 'boo_d5acc4', 'd5ysxc');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483632, 1, 'r0oz', 'dgj5i', 'lq5lnpim', 'boo_d5acc4', 'k58qs27p');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483631, 1, 'r94gth2m', 'ajjl', '3', 'boo_d5acc4', 'okv8uttmu2');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483630, 1, 'e578', 'fvy', '7zzbe8y', 'boo_d5acc4', 'kv42q7');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483629, 1, 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 'boo_d5acc4', 'o705');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483628, 1, 'a9n0jxfofws', 'do2zobb', 'q0k32od', 'boo_d5acc4', 'cl5ams');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, n AS count___ FROM (SELECT category, YEAR, COUNT(*) AS n FROM book_club GROUP BY category, YEAR) ORDER BY category, count___ NULLS LAST;

/*
Gold Result:
(None, 3)
('boo_d5acc4', 3)
('boo_d5acc4', 15)
*/

-- Prediction Query
SELECT category, COUNT(*) FROM book_club GROUP BY category;

/*
Prediction Result:
(None, 3)
('boo_d5acc4', 18)
*/
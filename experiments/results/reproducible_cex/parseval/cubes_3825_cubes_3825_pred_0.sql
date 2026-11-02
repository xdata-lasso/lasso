-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: book_club --
INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'boo_88a3d1', 'e4', 'hria2ypuzhs');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483647, 700293388, 'wbbp6luhvdlt', 'ilbnp', 'boo_88a3d1', 'mdpos', 'ie5');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483646, -1209887326, 'klfa9000t', 'c4ecigce', 'boo_88a3d1', '76nium52', 'zbuo4nrqrof');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (2, 373262291, 'p5s5bbp', '02eutliqa11r', 'boo_88a3d1', 'ytoo3o9', 'l7');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (3, 1178636309, 'ex1', 'ji7zwau2', 'boo_88a3d1', 'dwyrq13pyu78', '9');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483645, 244829661, 'jsl', 'b4yp5qi', 'boo_88a3d1', 'rkf9vqx5', 'pz0f8jegd');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483642, -283454505, '9uxj4hw', 'd', 'A', 'lph2gn', 'q');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483641, -664193365, 'cx5hn', 'p', 'A', 'jtu0d', '79fjgq8');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483640, -1255130038, '3d', 'qv0gcb98ozk', '@', 'zbilyrkn', '6vck6ah0f8js');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483639, -658391922, 'q7x', '7', 'O', '2fxa7ryfdrz', '16nijjai5dh');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483638, 1583472758, 'rg', 'd8y', 'O', 't1afgog', 'itsj3');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483637, -491938169, '1q43', '1jh3den', 'A', 'c68x8vacx', 'afu5w1of7');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483636, 76996700, 'o72ctdc', 'mfg62', 'O', '0v', 'q8qdjpe1');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483635, -1180042408, '78507cvt', 'ptt', 'O', '6b', 'ou5z');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483634, 1691780814, '6c4bfkfo', 'c', 'A', '0', '7z2zezjo7wg');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483633, 1248858185, '5', 'sxcmr0o', '_', 'ztdgj5i3lq5l', 'pim5');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483632, -1125548818, '94gth', '2mnajjla3o', '_', 'v8u', 'tmu2n');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483631, -1817527403, '78lfvyz7zz', 'be8yvkv42q7', 'A', 'x58b4', 'pmaus3auvmkr');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483630, 609771851, 'j', 'wzw5chn9mo70', NULL, 'a9n0jxfo', 'ws');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483629, 1719800120, 'o', '2zobb0q0k32o', NULL, 'w', 'l');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483628, 895277769, 'amsorlwyng', '1', NULL, 'j', '9erhizgk1yoe');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483627, 1483450542, 'o6l0hdt6fu', 'yxuzk', 'boo_88a3d1', '5', '1gwnlas6');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483626, -2076274980, 'ow', 'i1z', 'boo_88a3d1', 'nxih662q', 'xlyotow9');

INSERT INTO "book_club" ("book_club_id", "year", "author_or_editor", "book_title", "publisher", "category", "result") VALUES (-2147483625, 727608179, 'awg96aqb0tbi', 'ndz39tajz9', 'boo_88a3d1', 'd8n5w', 'g');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM (SELECT book_club_id, maxn, publisher, book_club_id AS n FROM (SELECT LHS.book_club_id AS book_club_id, LHS.maxn AS maxn, RHS.publisher AS publisher FROM (SELECT book_club_id, MAX(n) AS maxn FROM (SELECT book_club_id, publisher, COUNT(*) AS n FROM book_club GROUP BY book_club_id, publisher) GROUP BY book_club_id) AS LHS INNER JOIN (SELECT book_club_id, publisher, COUNT(*) AS n FROM book_club GROUP BY book_club_id, publisher) AS RHS ON (LHS.book_club_id = RHS.n AND LHS.maxn = RHS.book_club_id))) ORDER BY publisher;

/*
Gold Result:
*/

-- Prediction Query
SELECT publisher FROM book_club GROUP BY publisher ORDER BY COUNT(*) DESC, publisher NULLS LAST LIMIT 1;

/*
Prediction Result:
('boo_88a3d1',)
*/
-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: artist --
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483648, '5k5swwqcgs', '9n8', 1610062532, -106629402);

-- Inserting into table: exhibition --
INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (1, -2147483648, 2004, 't2__6b3379', 935.695299);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (-2147483647, -2147483648, 2004, 't2__6b3379', 86.520366);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (3, -2147483648, -1633151678, 'a2y', 797.015047);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (2, -2147483648, 2004, 't2__6b3379', 718.397869);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (4, -2147483648, 2004, 't2__d8ab3b', 334.878198);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (5, -2147483648, 2004, 't2__d8ab3b', 179.378884);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (6, -2147483648, NULL, '5sw', 357.862717);

-- Inserting into table: exhibition_record --
INSERT INTO "exhibition_record" ("exhibition_id", "date", "attendance") VALUES (1, 't1__b473ca', 1);

INSERT INTO "exhibition_record" ("exhibition_id", "date", "attendance") VALUES (3, 't1__b473ca', 1);

INSERT INTO "exhibition_record" ("exhibition_id", "date", "attendance") VALUES (1, 't1__f23ccf', 1);

INSERT INTO "exhibition_record" ("exhibition_id", "date", "attendance") VALUES (1, 'date_3', -841692980);

INSERT INTO "exhibition_record" ("exhibition_id", "date", "attendance") VALUES (4, 'A', 1);

INSERT INTO "exhibition_record" ("exhibition_id", "date", "attendance") VALUES (5, 'A', 1);

INSERT INTO "exhibition_record" ("exhibition_id", "date", "attendance") VALUES (6, 'date_5', 1258409369);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme, date, attendance FROM (SELECT LHS.exhibition_id AS exhibition_id, LHS.year AS YEAR, LHS.theme AS theme, LHS.artist_id AS artist_id, LHS.ticket_price AS ticket_price, RHS.date AS date, RHS.attendance AS attendance FROM (SELECT * FROM exhibition WHERE (YEAR <= 2004)) AS LHS INNER JOIN exhibition_record AS RHS ON (LHS.exhibition_id = RHS.exhibition_id)) ORDER BY theme, date NULLS LAST, attendance NULLS LAST;

/*
Gold Result:
('a2y', 't1__b473ca', 1)
('t2__6b3379', 'date_3', -841692980)
('t2__6b3379', 't1__b473ca', 1)
('t2__6b3379', 't1__f23ccf', 1)
('t2__d8ab3b', 'A', 1)
('t2__d8ab3b', 'A', 1)
*/

-- Prediction Query
SELECT T2.theme, T1.date, T1.attendance FROM exhibition_record AS T1 JOIN exhibition AS T2 ON T1.exhibition_id = T2.exhibition_id WHERE T2.year = 2004;

/*
Prediction Result:
('t2__6b3379', 'date_3', -841692980)
('t2__6b3379', 't1__b473ca', 1)
('t2__6b3379', 't1__f23ccf', 1)
('t2__d8ab3b', 'A', 1)
('t2__d8ab3b', 'A', 1)
*/
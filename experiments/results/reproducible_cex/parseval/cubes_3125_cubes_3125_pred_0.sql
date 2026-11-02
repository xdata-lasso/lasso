-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: artist --
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483648, '5k5swwqcgs', '9n8', 1610062532, -106629402);

-- Inserting into table: exhibition --
INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (1, -2147483648, 1, 'exh_a64da7', 15.0);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (2, -2147483648, 1, 'exh_a64da7', 15.0);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (3, -2147483648, 1160656988, 'ia2yp', 15.01);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (4, -2147483648, 1644814318, 'sr', NULL);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (5, -2147483648, 1908028688, NULL, 15.0);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (6, -2147483648, NULL, 'p6luhvdlttil', 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme, YEAR FROM exhibition WHERE (ticket_price <= 15.0) ORDER BY theme, exhibition.exhibition_id NULLS LAST;

/*
Gold Result:
(None, 1908028688)
('exh_a64da7', 1)
('exh_a64da7', 1)
('p6luhvdlttil', None)
*/

-- Prediction Query
SELECT theme, YEAR FROM exhibition WHERE ticket_price < 15;

/*
Prediction Result:
*/
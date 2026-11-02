-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1038, 'Brandon Davis', 'Tanzania', 1039, 1040);
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1044, 'Renee Blair', 'Mauritania', 1045, 1046);
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1050, 'Jamie Arnold', 'Switzerland', 1051, 1052);
INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (1041, 1038, 1042, 'guy', 1043.5);
INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (1047, 1044, 1042, 'value', 1049.5);
INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (1053, 1050, 1043, 'present', 1055.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme, YEAR FROM exhibition ORDER BY theme, exhibition.exhibition_id NULLS LAST;

/*
Gold Result:
('guy', 1042)
('present', 1043)
('value', 1042)
*/

-- Prediction Query
SELECT theme, YEAR FROM exhibition ORDER BY ticket_price DESC, exhibition.exhibition_id NULLS LAST;

/*
Prediction Result:
('present', 1043)
('value', 1042)
('guy', 1042)
*/
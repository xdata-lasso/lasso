-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: artist --
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483648, 'art_f162cc', '5k5swwqcgs', 247012447, -1980249628);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1, 't2__116970', 'gu7v', -1865039888, 1160656988);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (2, 'art_f162cc', 'zhsrwb', 2122220075, 1072996612);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (3, 'art_f162cc', 'luhvdltti', -1364429300, -1257178728);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483646, 't2__e37c41', 'mdpos', -1576219117, -1823627488);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483643, 'art_f162cc', 'gce376nium', 283598170, 742285925);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483642, 'art_bb3c10', 'u', -1179823637, 1119186446);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483641, 'art_f162cc', 'ryytoo3', -1666765085, 1178636309);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483640, 'art_f162cc', '7zw', 481163439, 2123196517);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483639, 'art_f162cc', 'rljsl0b4y', -1116181514, 1255852738);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483638, 'art_f162cc', '9v', 556727997, 1178000634);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483637, 'art_f162cc', 'vy9uxj4', -1612443122, -2050247126);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483636, 'art_f162cc', 'hncprjtu0dz', -1748371085, -1742081330);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483635, 'art_f162cc', 'n2f3dqv0g', 1382410067, 1631231566);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483634, 'art_f162cc', '8ozk3zbil', 982314585, 638024588);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483633, 'art_f162cc', '6vck6ah0f8js', -658391922, -1388029300);

INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (-2147483632, NULL, 'r', 777149609, 61479715);

-- Inserting into table: exhibition --
INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (-2147483648, 1, 2004, 'ia2yp', 718.397869);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (-2147483647, 1, 2004, 'nw6klf', 741.842896);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (-2147483646, 1, 2004, '9000t5c4ec', 128.76421);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (-2147483645, 2, 2004, 'rqrofqyp5s', 499.570479);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (-2147483644, 3, 2004, 'bbp02eutliqa', 427.383654);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (-2147483643, 3, 2004, 'ex1', 482.572691);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (-2147483642, 3, 2004, 'dwyrq13pyu78', 49.538289);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (-2147483641, 3, 2004, '2rk', 811.601922);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (-2147483640, 3, 2004, 'pz0f8jegd', 452.27611);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (2, 1, 2004, 'lph2gn', 58.749749);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (3, 1, 2004, 'wnqcx', 668.309685);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (-2147483637, 1, 1, 'xb72fxa7r', 379.883722);

INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (-2147483636, 1, 2004, 'jja', 128.858335);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM artist AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM exhibition WHERE (YEAR = 2004)) AS RHS WHERE (LHS.artist_id = RHS.artist_id))) ORDER BY name;

/*
Gold Result:
(None,)
('art_bb3c10',)
('art_f162cc',)
('art_f162cc',)
('art_f162cc',)
('art_f162cc',)
('art_f162cc',)
('art_f162cc',)
('art_f162cc',)
('art_f162cc',)
('art_f162cc',)
('art_f162cc',)
('art_f162cc',)
('t2__e37c41',)
*/

-- Prediction Query
SELECT name FROM artist EXCEPT SELECT T2.name FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id = T2.artist_id WHERE T1.year = 2004;

/*
Prediction Result:
(None,)
('art_bb3c10',)
('t2__e37c41',)
*/
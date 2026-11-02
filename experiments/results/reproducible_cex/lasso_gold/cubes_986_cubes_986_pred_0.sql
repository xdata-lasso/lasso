-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (1001, 'Allison Hill', '89083 Robinson Radial
Lisatown, WV 21427', 1004.5, 1007.5);
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (1002, 'Noah Rhodes', '2351 Noah Knolls Suite 940
Herrerafurt, CO 72858', 1013.5, 1018.5);
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (1003, 'Angie Henderson', '310 Kendra Common Apt. 164
Reidstad, GA 49021', 1022.5, 1029.5);
INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (1010, 1001, 'Michael Miles', 'expect', 'wish');
INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (1011, 1001, 'Andrea Reid', 'expect', 'push');
INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (1012, 1001, 'Danielle Ford', 'expect', 'rise');
INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (1013, 1001, 'Melinda Cameron', 'yes', 'our');
INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (1014, 1001, 'Crystal Johnson', 'yes', 'under');
INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (1015, 1001, 'Derek Clark', 'yes', 'serious');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT CLASS FROM (SELECT LHS.class AS CLASS, LHS.track_id AS track_id, LHS.n AS n, RHS.class AS class_other, RHS.track_id AS track_id_other, RHS.n AS n_other FROM (SELECT CLASS, track_id, COUNT(*) AS n FROM race GROUP BY CLASS, track_id) AS LHS CROSS JOIN (SELECT CLASS, track_id, COUNT(*) AS n FROM race GROUP BY CLASS, track_id) AS RHS) WHERE (n > n_other) ORDER BY CLASS;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM race GROUP BY CLASS ORDER BY COUNT(*) DESC, CLASS NULLS LAST LIMIT 1;

/*
Prediction Result:
('expect',)
*/
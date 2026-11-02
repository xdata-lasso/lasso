-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1010, 'Jennifer Cole', 1014.5, 1015.5, 'husband', 'Bhutan');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1011, 'Sean Blake', 1014.5, 1024.5, 'husband', 'Guinea-Bissau');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1012, 'Jay Ramirez', 1014.5, 1033.5, 'husband', 'Tanzania');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1013, 'Phillip Garcia', 1014.5, 1042.5, 'husband', 'Guatemala');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1019, NULL, 1023.5, 1024.5, 'answer', 'Panama');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1020, NULL, 1023.5, 1033.5, 'answer', 'Denmark');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1021, NULL, 1023.5, 1042.5, 'answer', 'Sierra Leone');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1022, NULL, 1023.5, 1051.5, 'answer', 'French Guiana');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RANGE FROM (SELECT * FROM (SELECT * FROM (SELECT height, RANGE, COUNT(*) AS n FROM mountain GROUP BY height, RANGE) ORDER BY RANGE DESC) LIMIT 1);

/*
Gold Result:
('husband',)
*/

-- Prediction Query
SELECT RANGE FROM mountain GROUP BY RANGE ORDER BY COUNT(*) DESC, RANGE NULLS LAST LIMIT 1;

/*
Prediction Result:
('answer',)
*/
-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1001.5, 'Allison Hill', 1011.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1002.5, 'Allison Hill', 1018.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1003.5, 'Allison Hill', 1025.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1004.5, 'Allison Hill', 1032.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1005.5, 'Allison Hill', 1039.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1006.5, 'Allison Hill', 1046.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1007.5, 'Allison Hill', 1053.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1008.5, 'Allison Hill', 1060.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1009.5, 'Allison Hill', 1067.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1010.5, 'Allison Hill', 1074.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT aid, name, AVG(distance) AS meandistance FROM aircraft GROUP BY aid, name) ORDER BY meandistance DESC) LIMIT 7);

/*
Gold Result:
('Allison Hill',)
('Allison Hill',)
('Allison Hill',)
('Allison Hill',)
('Allison Hill',)
('Allison Hill',)
('Allison Hill',)
*/

-- Prediction Query
SELECT name FROM Aircraft WHERE distance > (SELECT AVG(distance) FROM Aircraft);

/*
Prediction Result:
('Allison Hill',)
('Allison Hill',)
('Allison Hill',)
('Allison Hill',)
('Allison Hill',)
*/
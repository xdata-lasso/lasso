-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1006.5, 'Megan Mcclain', 1007.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1022.5, 'Jerry Ramirez', 1023.5);
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1027.5, 'Caitlin Henderson', 1028.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1008.5, 1006.5, 'begin', 'Nauru', 1009.5, '1972-03-03', '1973-04-04', 1010.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1024.5, 1022.5, NULL, 'Albania', 1025.5, '1977-08-08', '1978-09-09', 1026.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1029.5, 1027.5, 'fall', 'Cape Verde', 1030.5, '1979-10-10', '1978-09-09', 1031.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1032.5, 1006.5, NULL, 'Nauru', 1009.5, '1972-03-03', '1973-04-04', 1010.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT origin, n AS count___ FROM (SELECT arrival_date, origin, COUNT(*) AS n FROM flight GROUP BY arrival_date, origin) ORDER BY origin, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
(None, 1)
('begin', 1)
('fall', 1)
*/

-- Prediction Query
SELECT origin, COUNT(*) FROM Flight GROUP BY origin;

/*
Prediction Result:
(None, 2)
('begin', 1)
('fall', 1)
*/
-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "name", "distance") VALUES (1044.5, 'Daniel Gallagher', 1045.5);
INSERT INTO "flight" ("flno", "aid", "origin", "destination", "distance", "departure_date", "arrival_date", "price") VALUES (1046.5, 1044.5, 'Los Angeles_z', 'Honolulu', 1047.5, '1984-04-15', '1985-05-16', 1048.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanprice" AS "avg_price_" FROM (SELECT "destination", "origin", AVG("price") AS "meanprice" FROM (SELECT * FROM "flight" WHERE ("origin" = 'Los Angeles' AND "destination" = 'Honolulu')) GROUP BY destination, origin) ORDER BY avg_price_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(price) FROM Flight WHERE origin = 'Los Angeles' AND destination = 'Honolulu';

/*
Prediction Result:
(None,)
*/
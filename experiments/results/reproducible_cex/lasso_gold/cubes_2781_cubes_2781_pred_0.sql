-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1006, 'Angie Henderson', 1007.5, 1008.5, 'all');
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1011, 'Cristian Santos', 1012.5, 1013.5, 'offer');
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1016, 'Olivia Moore', 1017.5, 1018.5, 'knowledge');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1009, 1006, 'Robinson PLC', 1010.5, 'play');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1014, NULL, 'Robinson-Lawrence', 1015.5, 'table');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1019, 1016, 'Ramirez-Lewis', 1020.5, 'source');
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (1021, NULL, 'Robinson PLC', 1010.5, 'play');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count_distinct_company_ FROM entrepreneur ORDER BY count_distinct_company_;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT Company) FROM entrepreneur;

/*
Prediction Result:
(3,)
*/
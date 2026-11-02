-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1058, 'Laura Kennedy', 1059.5, 1060.5, 'Aguirreborough');
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1065, 'Shannon Jones', 1066.5, 1067.5, 'North Deniseside');
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1072, 'Tyler Cowan', 1073.5, 1074.5, 'Mooreport');
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1061, 1058, 'between', 1062.5, '6670 Bruce Stream Suite 133
New Shane, NE 24551', 'Fiji', 100, 1064);
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1068, 1065, 'between', 1069.5, '26773 Barrera Expressway
Smithfurt, KS 60139', 'France', -50, 1071);
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1075, 1072, 'art', 1076.5, 'Unit 9805 Box 0097
DPO AP 70116', 'Cayman Islands', 80, 1078);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM perpetrator ORDER BY date, perpetrator.perpetrator_id NULLS LAST;

/*
Gold Result:
('art',)
('between',)
('between',)
*/

-- Prediction Query
SELECT Date FROM perpetrator ORDER BY Killed DESC, perpetrator.perpetrator_id NULLS LAST;

/*
Prediction Result:
('between',)
('art',)
('between',)
*/
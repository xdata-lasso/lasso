-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1017, 'Matthew Mejia', 1018.5, 1019.5, 'Port Jesseville');
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1031, 'Zachary Taylor', 1032.5, 1033.5, 'Daviston');
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1020, 1017, 'husband', 1021.5, '55341 Amanda Gardens Apt. 764
Lake Mark, WI 07832', 'Denmark', 1022, 1023);
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1027, 1017, 'under', 1028.5, '767 Joseph Gateway
Juliechester, MH 76985', 'Iran', 1029, 1030);
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1034, 1031, 'traditional', 1035.5, '691 James Mountain
Tashatown, TX 94967', 'Brazil', 1036, 1037);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE EXISTS(SELECT 1 FROM perpetrator AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
('Matthew Mejia',)
('Zachary Taylor',)
*/

-- Prediction Query
SELECT T1.Name FROM people AS T1 JOIN perpetrator AS T2 ON T1.People_ID = T2.People_ID;

/*
Prediction Result:
('Matthew Mejia',)
('Matthew Mejia',)
('Zachary Taylor',)
*/
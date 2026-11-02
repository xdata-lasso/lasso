-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1008, 'Jonathan Johnson', 1009.5, 1010.5, 'Lake Debra');
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1011, 'Christopher Bernard', 1010.5, 1011.5, 'Port Lindachester');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
('Christopher Bernard',)
('Jonathan Johnson',)
*/

-- Prediction Query
SELECT Name FROM People ORDER BY Height ASC, People.people_id NULLS LAST;

/*
Prediction Result:
('Jonathan Johnson',)
('Christopher Bernard',)
*/
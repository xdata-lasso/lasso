-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (1, 'Alice', 170.5, 65.0, 'New York');
INSERT INTO "people" ("People_ID", "Name", "Height", "Weight", "Home Town") VALUES (2, 'Bob', 180.0, 80.5, 'Los Angeles');
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (1, 1, '04.26 April 26', 1982.0, 'Uiryeong', 'South Korea', 56, 37);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (2, 1, '11.18 Nov 18', 1994.0, 'Fuxin', 'China', 234, 50);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (3, 2, '04.26 April 26', 1982.0, 'Uiryeong', 'South Korea', 0, 0);
INSERT INTO "perpetrator" ("Perpetrator_ID", "People_ID", "Date", "Year", "Location", "Country", "Killed", "Injured") VALUES (4, NULL, '01.01 Jan 1', 2000.0, 'Unknown', 'USA', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM perpetrator ORDER BY date, perpetrator.perpetrator_id NULLS LAST;

/*
Gold Result:
('01.01 Jan 1',)
('04.26 April 26',)
('04.26 April 26',)
('11.18 Nov 18',)
*/

-- Prediction Query
SELECT Date FROM perpetrator ORDER BY Killed DESC, perpetrator.perpetrator_id NULLS LAST;

/*
Prediction Result:
('11.18 Nov 18',)
('04.26 April 26',)
('01.01 Jan 1',)
('04.26 April 26',)
*/
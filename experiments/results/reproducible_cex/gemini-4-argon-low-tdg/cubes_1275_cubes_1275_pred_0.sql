-- Schema DDL
CREATE TABLE "pilot" ("Pilot_Id" INTEGER(11) PRIMARY KEY, "Name" TEXT(50), "Age" INTEGER(11));

CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER(11) PRIMARY KEY, "Aircraft" TEXT(50), "Description" TEXT(50), "Max_Gross_Weight" TEXT(50), "Total_disk_area" TEXT(50), "Max_disk_Loading" TEXT(50));

CREATE TABLE "match" ("Round" REAL PRIMARY KEY, "Winning_Pilot" TEXT, "Winning_Aircraft" TEXT, "Location" TEXT, "Country" TEXT, "Date" TEXT, "Fastest_Qualifying" TEXT, FOREIGN KEY ("Winning_Pilot") REFERENCES "pilot" ("Pilot_Id"), FOREIGN KEY ("Winning_Aircraft") REFERENCES "aircraft" ("Aircraft_ID"));

CREATE TABLE "airport" ("Airport_ID" INTEGER PRIMARY KEY, "Airport_Name" TEXT, "Total_Passengers" REAL, "%_Change_2007" TEXT, "International_Passengers" REAL, "Domestic_Passengers" REAL, "Transit_Passengers" REAL, "Aircraft_Movements" REAL, "Freight_Metric_Tonnes" REAL);

CREATE TABLE "airport_aircraft" ("Airport_ID" INTEGER, "Aircraft_ID" INTEGER, "ID" INTEGER, PRIMARY KEY ("Airport_ID", "Aircraft_ID"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Airport_ID") REFERENCES "airport" ("Airport_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name (out of insertion/PK order), duplicate names (DISTINCT vs ALL), and NULLS LAST on pilot_id.
INSERT INTO "pilot" ("Pilot_Id", "Name", "Age") VALUES (1, 'Charlie', 35);
INSERT INTO "pilot" ("Pilot_Id", "Name", "Age") VALUES (2, 'Alice', 28);
INSERT INTO "pilot" ("Pilot_Id", "Name", "Age") VALUES (3, 'Alice', 40);
INSERT INTO "pilot" ("Pilot_Id", "Name", "Age") VALUES (4, 'Bob', 30);
INSERT INTO "pilot" ("Pilot_Id", "Name", "Age") VALUES (NULL, 'Alice', 22);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM pilot ORDER BY name, pilot.pilot_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT Name FROM pilot ORDER BY Age DESC, pilot.pilot_id NULLS LAST;

/*
Prediction Result:
('Alice',)
('Charlie',)
('Bob',)
('Alice',)
('Alice',)
*/
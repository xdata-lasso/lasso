-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (Aircraft_ID, Order_Year, Manufacturer, Model, Fleet_Series, Powertrain, Fuel_Propulsion) VALUES (101, 2015, 'Boeing', '737', 'B737-800', 'Jet', 'Kerosene');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (1, 'Alice', 10, 20, 'Zambia', 'PosA', 2010, 'Red');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (5, 'Eve', 11, 25, 'India', 'PosA', 2011, 'Red');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (2, 'Bob', 12, 35, 'Brazil', 'PosB', 2012, 'Blue');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (3, 'Charlie', 13, 30, 'Argentina', 'PosB', 2013, 'Blue');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (4, 'David', 14, 35, 'Egypt', 'PosB', 2014, 'Blue');
INSERT INTO pilot (Pilot_ID, Pilot_name, Rank, Age, Nationality, Position, Join_Year, Team) VALUES (6, 'Frank', 15, 35, 'Canada', 'PosB', 2015, 'Blue');
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (1, 101, '2020-01-01', 1001);
INSERT INTO pilot_record (Pilot_ID, Aircraft_ID, Date, Record_ID) VALUES (3, 101, '2020-01-02', 1002);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT LHS.pilot_id AS pilot_id, LHS.pilot_name AS pilot_name, LHS.rank AS rank, LHS.age AS age, LHS.nationality AS nationality, LHS.position AS POSITION, LHS.join_year AS join_year, LHS.team AS team FROM pilot AS LHS INNER JOIN (SELECT POSITION, MAX(n) AS n FROM (SELECT age, POSITION, COUNT(*) AS n FROM pilot GROUP BY age, POSITION) GROUP BY POSITION) AS RHS ON (LHS.pilot_id = RHS.n AND LHS.position = RHS.position)) ORDER BY nationality;

/*
Gold Result:
('Argentina',)
('Zambia',)
*/

-- Prediction Query
SELECT Nationality FROM pilot GROUP BY Nationality ORDER BY COUNT(*) DESC, Nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
('Argentina',)
*/
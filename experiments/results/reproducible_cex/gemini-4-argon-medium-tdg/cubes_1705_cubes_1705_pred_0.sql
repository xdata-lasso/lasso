-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests join condition LHS.id = RHS.id vs LHS.id = RHS.company_id vs LHS.id = RHS.airport_id
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (1, 'London', 'UK', 'LHR', 'EGLL', 'Heathrow');
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (1, 'CompA', 'TypeA_MatchIdOnly', 'Flights', 'UK', 50.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (2, 'CompB', 'TypeB_MatchCompIdOnly', 'Cargo', 'US', 100.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (3, 'CompC', 'TypeC_NoMatch', 'Charter', 'FR', 75.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (1, 2, 1, 'FL001', '2023-01-01', 'Smith', 150.0, 10000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM (SELECT * FROM operate_company AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM flight WHERE (velocity <> 200.0)) AS RHS WHERE (LHS.id = RHS.id))) ORDER BY TYPE;

/*
Gold Result:
('TypeB_MatchCompIdOnly',)
('TypeC_NoMatch',)
*/

-- Prediction Query
SELECT DISTINCT T1.type FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id WHERE T2.velocity < 200;

/*
Prediction Result:
('TypeB_MatchCompIdOnly',)
*/
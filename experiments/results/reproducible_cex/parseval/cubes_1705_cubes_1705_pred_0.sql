-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: operate_company --
INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (1, 'lhs_ae618f', 'lhs_106221', 'lhs_9ef16d', 'lhs_83f5b6', 1.0);

INSERT INTO "operate_company" ("id", "name", "type", "principal_activities", "incorporated_in", "group_equity_shareholding") VALUES (-2147483647, 'lhs_78e69e', 'lhs_04af16', 'lhs_3cbe77', 'lhs_015a59', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM (SELECT * FROM operate_company AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM flight WHERE (velocity <> 200.0)) AS RHS WHERE (LHS.id = RHS.id))) ORDER BY TYPE;

/*
Gold Result:
('lhs_04af16',)
('lhs_106221',)
*/

-- Prediction Query
SELECT DISTINCT T1.type FROM operate_company AS T1 JOIN flight AS t2 ON T1.id = T2.company_id WHERE T2.velocity < 200;

/*
Prediction Result:
*/
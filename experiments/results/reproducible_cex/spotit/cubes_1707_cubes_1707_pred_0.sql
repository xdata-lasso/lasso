-- Schema DDL
CREATE TABLE "AIRPORT" (
    "ID" INT,
    "CITY" TEXT,
    "COUNTRY" TEXT,
    "IATA" TEXT,
    "ICAO" TEXT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "OPERATE_COMPANY" (
    "ID" INT,
    "NAME" TEXT,
    "TYPE" TEXT,
    "PRINCIPAL_ACTIVITIES" TEXT,
    "INCORPORATED_IN" TEXT,
    "GROUP_EQUITY_SHAREHOLDING" FLOAT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "FLIGHT" (
    "ID" INT,
    "COMPANY_ID" INT,
    "AIRPORT_ID" INT,
    "VEHICLE_FLIGHT_NUMBER" TEXT,
    "DATE" TEXT,
    "PILOT" TEXT,
    "VELOCITY" FLOAT,
    "ALTITUDE" FLOAT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("COMPANY_ID") REFERENCES "OPERATE_COMPANY"("ID"),
    FOREIGN KEY ("AIRPORT_ID") REFERENCES "AIRPORT"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO AIRPORT VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO AIRPORT VALUES (2, 0, 0, 0, 0, 0);
INSERT INTO OPERATE_COMPANY VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO OPERATE_COMPANY VALUES (-1, 0, 0, 0, 0, 0);
INSERT INTO FLIGHT VALUES (2, 0, 1, 17, 18, 0, 16, 19);
INSERT INTO FLIGHT VALUES (0, 0, 2, 11, 12, -1, 13, 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT pilot FROM (SELECT airport_id, velocity, n, vehicle_flight_number, date, pilot, velocity_other, altitude, company_id, airport_id AS id FROM (SELECT LHS.airport_id AS airport_id, LHS.velocity AS velocity, LHS.n AS n, RHS.vehicle_flight_number AS vehicle_flight_number, RHS.date AS date, RHS.pilot AS pilot, RHS.velocity AS velocity_other, RHS.altitude AS altitude, RHS.company_id AS company_id FROM (SELECT airport_id, velocity, COUNT(*) AS n FROM flight GROUP BY airport_id, velocity) AS LHS INNER JOIN flight AS RHS ON (LHS.airport_id = RHS.id AND LHS.n = RHS.airport_id))) ORDER BY pilot;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT pilot FROM flight GROUP BY pilot ORDER BY COUNT(*) DESC, pilot NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/
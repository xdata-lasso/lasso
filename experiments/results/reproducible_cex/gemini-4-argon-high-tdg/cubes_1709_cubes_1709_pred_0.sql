-- Schema DDL
CREATE TABLE "airport" ("id" INTEGER PRIMARY KEY, "City" TEXT, "Country" TEXT, "IATA" TEXT, "ICAO" TEXT, "name" TEXT);

CREATE TABLE "operate_company" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Type" TEXT, "Principal_activities" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL);

CREATE TABLE "flight" ("id" INTEGER PRIMARY KEY, "company_id" INTEGER, "airport_id" INTEGER, "Vehicle_Flight_number" TEXT, "Date" TEXT, "Pilot" TEXT, "Velocity" REAL, "Altitude" REAL, FOREIGN KEY ("company_id") REFERENCES "operate_company" ("id"), FOREIGN KEY ("airport_id") REFERENCES "airport" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (1, 'New York', 'USA', 'JFK', 'KJFK', 'John F. Kennedy International Airport');
INSERT INTO airport (id, City, Country, IATA, ICAO, name) VALUES (2, 'London', 'UK', 'LHR', 'EGLL', 'Heathrow Airport');
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (1, 'Delta Air Lines', 'Public', 'Airline', 'USA', 100.0);
INSERT INTO operate_company (id, name, Type, Principal_activities, Incorporated_in, Group_Equity_Shareholding) VALUES (2, 'British Airways', 'Public', 'Airline', 'UK', 100.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (1, 1, 1, 'FL-200', '2023-01-10', 'Alice', 500.0, 35000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (2, 1, 2, 'FL-100', '2023-05-20', 'Zack', 480.0, 32000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (3, 2, 1, 'FL-100', '2023-02-15', 'Bob', 510.0, 36000.0);
INSERT INTO flight (id, company_id, airport_id, Vehicle_Flight_number, Date, Pilot, Velocity, Altitude) VALUES (4, 2, 2, 'FL-300', '2023-03-01', 'Charlie', 490.0, 34000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT vehicle_flight_number, date, pilot FROM flight ORDER BY vehicle_flight_number, flight.id NULLS LAST;

/*
Gold Result:
('FL-100', '2023-05-20', 'Zack')
('FL-100', '2023-02-15', 'Bob')
('FL-200', '2023-01-10', 'Alice')
('FL-300', '2023-03-01', 'Charlie')
*/

-- Prediction Query
SELECT vehicle_flight_number, date, pilot FROM flight ORDER BY altitude ASC, flight.id NULLS LAST;

/*
Prediction Result:
('FL-100', '2023-05-20', 'Zack')
('FL-300', '2023-03-01', 'Charlie')
('FL-200', '2023-01-10', 'Alice')
('FL-100', '2023-02-15', 'Bob')
*/
-- Schema DDL
CREATE TABLE "airlines" ("uid" INTEGER PRIMARY KEY, "Airline" TEXT, "Abbreviation" TEXT, "Country" TEXT);

CREATE TABLE "airports" ("AirportCode" TEXT PRIMARY KEY, "City" TEXT, "AirportName" TEXT, "Country" TEXT, "CountryAbbrev" TEXT);

CREATE TABLE "flights" ("Airline" INTEGER, "FlightNo" INTEGER, "DestAirport" TEXT, "SourceAirport" TEXT, PRIMARY KEY ("Airline", "FlightNo"), FOREIGN KEY ("DestAirport") REFERENCES "airports" ("AirportCode"), FOREIGN KEY ("SourceAirport") REFERENCES "airports" ("AirportCode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airports" ("airportcode", "city", "airportname", "country", "countryabbrev") VALUES ('knowledge', 'Joshuaborough', 'Sean Blake', 'Bhutan', 'Guinea-Bissau');
INSERT INTO "airports" ("airportcode", "city", "airportname", "country", "countryabbrev") VALUES ('science', 'Robinsonshire', 'Lindsey Roman', 'Cayman Islands', 'Qatar');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT airportname FROM airports ORDER BY airportname, airports.airportcode NULLS LAST;

/*
Gold Result:
('Lindsey Roman',)
('Sean Blake',)
*/

-- Prediction Query
SELECT AirportName FROM Airports WHERE NOT AirportCode IN (SELECT SourceAirport FROM Flights UNION SELECT DestAirport FROM Flights);

/*
Prediction Result:
('Sean Blake',)
('Lindsey Roman',)
*/
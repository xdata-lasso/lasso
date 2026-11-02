-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (1, 'ThemeA', 'Zebra', '2001', '2002', 8);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (2, 'ThemeB', 'Alpha', '2003', '2004', 8);
INSERT INTO party (Party_ID, Party_Theme, Location, First_year, Last_year, Number_of_hosts) VALUES (3, 'ThemeC', 'Beta', '2005', '2006', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts FROM party AS LHS INNER JOIN (SELECT party_id, party_theme, LOCATION, first_year, last_year, MAX(number_of_hosts) OVER () AS number_of_hosts FROM party) AS RHS ON (LHS.party_id = RHS.party_id AND LHS.party_theme = RHS.party_theme AND LHS.location = RHS.location AND LHS.first_year = RHS.first_year AND LHS.last_year = RHS.last_year AND LHS.number_of_hosts = RHS.number_of_hosts)) ORDER BY LOCATION;

/*
Gold Result:
('Alpha',)
('Zebra',)
*/

-- Prediction Query
SELECT LOCATION FROM party ORDER BY Number_of_hosts DESC, party.party_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zebra',)
*/
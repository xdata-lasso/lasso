-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (1, 'Retro', 'Hall A', '2000', '2010', 20);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (2, 'Modern', 'Hall B', '2005', '2015', 19);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (3, 'Future', 'Hall C', '2010', '2020', 25);
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (1, 'Zack', 'USA', '30');
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (2, 'Alice', 'UK', '25');
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (3, 'Bob', 'Canada', '20');
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (4, 'Charlie', 'Australia', '40');
INSERT INTO "party_host" ("Party_ID", "Host_ID", "Is_Main_in_Charge") VALUES (1, 1, 1);
INSERT INTO "party_host" ("Party_ID", "Host_ID", "Is_Main_in_Charge") VALUES (2, 2, 1);
INSERT INTO "party_host" ("Party_ID", "Host_ID", "Is_Main_in_Charge") VALUES (3, 1, 0);
INSERT INTO "party_host" ("Party_ID", "Host_ID", "Is_Main_in_Charge") VALUES (3, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, LHS.host_id AS host_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, LHS.is_main_in_charge AS is_main_in_charge FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, LHS.host_id AS host_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, RHS.is_main_in_charge AS is_main_in_charge FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, RHS.host_id AS host_id, RHS.name AS name, RHS.nationality AS nationality, RHS.age AS age FROM party AS LHS CROSS JOIN host AS RHS) AS LHS INNER JOIN party_host AS RHS ON (LHS.party_id = RHS.party_id AND LHS.host_id = RHS.host_id)) AS LHS INNER JOIN (SELECT * FROM party WHERE (number_of_hosts >= 20)) AS RHS ON (LHS.party_id = RHS.party_id AND LHS.party_theme = RHS.party_theme AND LHS.location = RHS.location AND LHS.first_year = RHS.first_year AND LHS.last_year = RHS.last_year AND LHS.number_of_hosts = RHS.number_of_hosts)) ORDER BY name;

/*
Gold Result:
('Bob',)
('Zack',)
('Zack',)
*/

-- Prediction Query
SELECT T2.Name FROM party_host AS T1 JOIN HOST AS T2 ON T1.Host_ID = T2.Host_ID JOIN party AS T3 ON T1.Party_ID = T3.Party_ID WHERE T3.Number_of_hosts > 20;

/*
Prediction Result:
('Zack',)
('Bob',)
*/
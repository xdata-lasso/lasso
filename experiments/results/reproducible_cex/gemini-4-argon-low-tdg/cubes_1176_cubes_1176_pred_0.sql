-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join correctness, filtering out unlinked parties/hosts, and checking against unintended filters on Is_Main_in_Charge.
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (1, 'Gala', 'NY', '2010', '2020', 2);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (2, 'Disco', 'LA', '2015', '2015', 1);
INSERT INTO "party" ("Party_ID", "Party_Theme", "Location", "First_year", "Last_year", "Number_of_hosts") VALUES (3, 'Unassigned_Party', 'TX', '2000', '2005', 0);
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (10, 'Bob', 'USA', '30');
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (20, 'Alice', 'UK', '25');
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (30, 'Unassigned_Host', 'CA', '40');
INSERT INTO "party_host" ("Party_ID", "Host_ID", "Is_Main_in_Charge") VALUES (1, 10, 1);
INSERT INTO "party_host" ("Party_ID", "Host_ID", "Is_Main_in_Charge") VALUES (2, 20, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_theme, name FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, LHS.host_id AS host_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, RHS.is_main_in_charge AS is_main_in_charge FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, RHS.host_id AS host_id, RHS.name AS name, RHS.nationality AS nationality, RHS.age AS age FROM party AS LHS CROSS JOIN host AS RHS) AS LHS INNER JOIN party_host AS RHS ON (LHS.party_id = RHS.party_id AND LHS.host_id = RHS.host_id)) ORDER BY party_theme, name NULLS LAST;

/*
Gold Result:
('Disco', 'Alice')
('Gala', 'Bob')
*/

-- Prediction Query
SELECT T3.Party_Theme, T2.Name FROM party_host AS T1 JOIN HOST AS T2 ON T1.Host_ID = T2.Host_ID JOIN party AS T3 ON T1.Party_ID = T3.Party_ID;

/*
Prediction Result:
('Gala', 'Bob')
('Disco', 'Alice')
*/
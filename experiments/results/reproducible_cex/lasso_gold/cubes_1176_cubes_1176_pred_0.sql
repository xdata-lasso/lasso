-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1037, 'Clifford Ford', 'Bahrain', 'ground');
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1041, 'Jocelyn Wright', 'Morocco', 'material');
INSERT INTO "party" ("party_id", "party_theme", "location", "first_year", "last_year", "number_of_hosts") VALUES (1038, 'list', '11656 Owens Stream Apt. 106
Laurenville, IA 25613', 'customer', 'difficult', 1039);
INSERT INTO "party" ("party_id", "party_theme", "location", "first_year", "last_year", "number_of_hosts") VALUES (1042, 'against', '301 Jeremy Bypass
Chadbury, KY 88185', 'mention', 'not', 1040);
INSERT INTO "party_host" ("party_id", "host_id", "is_main_in_charge") VALUES (1038, 1037, 1040);
INSERT INTO "party_host" ("party_id", "host_id", "is_main_in_charge") VALUES (1042, 1041, 1044);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_theme, name FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, LHS.host_id AS host_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, RHS.is_main_in_charge AS is_main_in_charge FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, RHS.host_id AS host_id, RHS.name AS name, RHS.nationality AS nationality, RHS.age AS age FROM party AS LHS CROSS JOIN host AS RHS) AS LHS INNER JOIN party_host AS RHS ON (LHS.party_id = RHS.party_id AND LHS.host_id = RHS.host_id)) ORDER BY party_theme, name NULLS LAST;

/*
Gold Result:
('against', 'Jocelyn Wright')
('list', 'Clifford Ford')
*/

-- Prediction Query
SELECT T3.Party_Theme, T2.Name FROM party_host AS T1 JOIN HOST AS T2 ON T1.Host_ID = T2.Host_ID JOIN party AS T3 ON T1.Party_ID = T3.Party_ID;

/*
Prediction Result:
('list', 'Clifford Ford')
('against', 'Jocelyn Wright')
*/
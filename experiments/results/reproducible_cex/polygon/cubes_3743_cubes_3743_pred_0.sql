-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "party" ("party_id", "party_theme", "location", "first_year", "last_year", "number_of_hosts") VALUES (11, '18', '18', '18', '18', 18);
INSERT INTO "party" ("party_id", "party_theme", "location", "first_year", "last_year", "number_of_hosts") VALUES (10, '18', '18', '18', '18', 18);
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (17, '18', '19', '-636');
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (12, '14', '15', '-635');
INSERT INTO "party_host" ("party_id", "host_id", "is_main_in_charge") VALUES (10, 12, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, nationality FROM (SELECT LHS.host_id AS host_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, LHS.maxage AS maxage, RHS.host_id AS host_id_other, RHS.name AS name_other, RHS.nationality AS nationality_other, RHS.age AS age_other, RHS.maxage AS maxage_other FROM (SELECT host_id, name, nationality, age, MAX(age) OVER () AS maxage FROM host) AS LHS CROSS JOIN (SELECT host_id, name, nationality, age, MAX(age) OVER () AS maxage FROM host) AS RHS) WHERE (age = maxage AND age_other = maxage_other) ORDER BY name, nationality NULLS LAST;

/*
Gold Result:
('18', '19')
*/

-- Prediction Query
SELECT Name, Nationality FROM HOST ORDER BY Age DESC, HOST.host_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('18', '19')
*/
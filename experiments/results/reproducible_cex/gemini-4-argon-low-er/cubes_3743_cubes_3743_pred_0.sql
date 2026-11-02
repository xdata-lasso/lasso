-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (1, 'Alice', 'USA', '50');
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (2, 'Bob', 'UK', '50');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, nationality FROM (SELECT LHS.host_id AS host_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, LHS.maxage AS maxage, RHS.host_id AS host_id_other, RHS.name AS name_other, RHS.nationality AS nationality_other, RHS.age AS age_other, RHS.maxage AS maxage_other FROM (SELECT host_id, name, nationality, age, MAX(age) OVER () AS maxage FROM host) AS LHS CROSS JOIN (SELECT host_id, name, nationality, age, MAX(age) OVER () AS maxage FROM host) AS RHS) WHERE (age = maxage AND age_other = maxage_other) ORDER BY name, nationality NULLS LAST;

/*
Gold Result:
('Alice', 'USA')
('Alice', 'USA')
('Bob', 'UK')
('Bob', 'UK')
*/

-- Prediction Query
SELECT Name, Nationality FROM HOST ORDER BY Age DESC, HOST.host_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice', 'USA')
*/
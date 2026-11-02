-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO host (host_id, name, nationality, age) VALUES (0, NULL, 'default1', NULL), (1, 'default2', NULL, 'default1'), (2, 'default1', NULL, NULL), (3, 'default1', NULL, 'default2'), (4, 'default1', 'default2', 'default1'), (5, NULL, 'default2', 'default1'), (6, NULL, 'default2', NULL), (7, 'default1', 'default2', 'default1'), (8, 'default2', 'default1', NULL), (9, NULL, 'default2', 'default2');
INSERT INTO party (party_id, party_theme, location, first_year, last_year, number_of_hosts) VALUES (1, 'default2', 'default2', NULL, NULL, 1), (0, 'default2', 'default2', 'default2', 'default1', 1), (2, 'default1', 'default2', 'default1', 'default1', NULL), (3, 'default1', 'default1', NULL, NULL, 1);
INSERT INTO party_host (party_id, host_id, is_main_in_charge) VALUES (2, 3, 1), (1, 9, NULL), (3, 0, 1), (2, 9, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_theme, name FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, LHS.host_id AS host_id, LHS.name AS name, LHS.nationality AS nationality, LHS.age AS age, RHS.is_main_in_charge AS is_main_in_charge FROM (SELECT LHS.party_id AS party_id, LHS.party_theme AS party_theme, LHS.location AS LOCATION, LHS.first_year AS first_year, LHS.last_year AS last_year, LHS.number_of_hosts AS number_of_hosts, RHS.host_id AS host_id, RHS.name AS name, RHS.nationality AS nationality, RHS.age AS age FROM party AS LHS CROSS JOIN host AS RHS) AS LHS INNER JOIN party_host AS RHS ON (LHS.party_id = RHS.party_id AND LHS.host_id = RHS.host_id)) ORDER BY party_theme, name NULLS LAST;

/*
Gold Result:
('default1', 'default1')
('default1', None)
('default1', None)
('default2', None)
*/

-- Prediction Query
SELECT T3.Party_Theme, T2.Name FROM party_host AS T1 JOIN HOST AS T2 ON T1.Host_ID = T2.Host_ID JOIN party AS T3 ON T1.Party_ID = T3.Party_ID;

/*
Prediction Result:
('default2', None)
('default1', 'default1')
('default1', None)
('default1', None)
*/
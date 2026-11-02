-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO host (host_id, name, nationality, age) VALUES (1, 'default1', NULL, 'default1'), (2, NULL, NULL, 'default2'), (0, 'default2', NULL, 'default1');
INSERT INTO party (party_id, party_theme, location, first_year, last_year, number_of_hosts) VALUES (2, 'default1', NULL, 'default1', 'default2', 2), (1, NULL, NULL, NULL, 'default1', 2), (0, 'default2', 'default2', NULL, 'default2', 1), (3, 'default1', 'default1', NULL, 'default2', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM host AS LHS WHERE NOT EXISTS(SELECT 1 FROM party_host AS RHS WHERE (LHS.host_id = RHS.host_id))) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM HOST WHERE NOT Host_ID IN (SELECT Host_ID FROM party_host);

/*
Prediction Result:
('default2',)
('default1',)
(None,)
*/
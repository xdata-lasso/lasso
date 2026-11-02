-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1010, 'Derek Zuniga', 'Bolivia', 'hear');
INSERT INTO "host" ("host_id", "name", "nationality", "age") VALUES (1011, 'Bobby Hall', 'Heard Island and McDonald Islands', 'husband');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM host AS LHS WHERE NOT EXISTS(SELECT 1 FROM party_host AS RHS WHERE (LHS.host_id = RHS.host_id))) ORDER BY name;

/*
Gold Result:
('Bobby Hall',)
('Derek Zuniga',)
*/

-- Prediction Query
SELECT Name FROM HOST WHERE NOT Host_ID IN (SELECT Host_ID FROM party_host);

/*
Prediction Result:
('Derek Zuniga',)
('Bobby Hall',)
*/
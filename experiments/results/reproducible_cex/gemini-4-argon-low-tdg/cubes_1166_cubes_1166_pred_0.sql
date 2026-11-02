-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Empty `party` table (Window function with DISTINCT returns 0 rows vs scalar AVG which returns 1 row of NULL), and populated `host` table.
INSERT INTO "host" ("Host_ID", "Name", "Nationality", "Age") VALUES (1, 'Alice', 'USA', '30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(number_of_hosts) OVER () AS avg_number_of_hosts_ FROM party ORDER BY avg_number_of_hosts_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(Number_of_hosts) FROM party;

/*
Prediction Result:
(None,)
*/
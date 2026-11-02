-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "party" ("party_id", "party_theme", "location", "first_year", "last_year", "number_of_hosts") VALUES (1006, 'not', '283 Steven Groves
Lake Mark, WI 07832', 'drop', 'determine', 1007);
INSERT INTO "party" ("party_id", "party_theme", "location", "first_year", "last_year", "number_of_hosts") VALUES (1008, 'almost', '84959 Janet Cape Apt. 413
South Joshuastad, GA 49021', 'hear', 'term', 1008);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_theme, LOCATION FROM party ORDER BY party_theme, party.party_id NULLS LAST;

/*
Gold Result:
('almost', '84959 Janet Cape Apt. 413\nSouth Joshuastad, GA 49021')
('not', '283 Steven Groves\nLake Mark, WI 07832')
*/

-- Prediction Query
SELECT Party_Theme, LOCATION FROM party;

/*
Prediction Result:
('not', '283 Steven Groves\nLake Mark, WI 07832')
('almost', '84959 Janet Cape Apt. 413\nSouth Joshuastad, GA 49021')
*/
-- Schema DDL
CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Party_Theme" TEXT, "Location" TEXT, "First_year" TEXT, "Last_year" TEXT, "Number_of_hosts" INTEGER);

CREATE TABLE "host" ("Host_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Age" TEXT);

CREATE TABLE "party_host" ("Party_ID" INTEGER, "Host_ID" INTEGER, "Is_Main_in_Charge" INTEGER, PRIMARY KEY ("Party_ID", "Host_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"), FOREIGN KEY ("Host_ID") REFERENCES "host" ("Host_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "party" ("party_id", "party_theme", "location", "first_year", "last_year", "number_of_hosts") VALUES (1027, 'Spring', '47317 Brent Plains Apt. 132
Tuckerborough, VI 53066', 'step', 'recently', 1029);
INSERT INTO "party" ("party_id", "party_theme", "location", "first_year", "last_year", "number_of_hosts") VALUES (1028, 'Teqnology', 'PSC 2606, Box 4746
APO AP 96249', 'only', 'serious', 1042.0);
INSERT INTO "party" ("party_id", "party_theme", "location", "first_year", "last_year", "number_of_hosts") VALUES (1031, 'Spring', '3098 Julie Centers
New Thomashaven, GA 07956', 'author', 'training', 1033);
INSERT INTO "party" ("party_id", "party_theme", "location", "first_year", "last_year", "number_of_hosts") VALUES (1032, 'Teqnology', 'USS York
FPO AE 78493', 'Republican', 'easy', 1046.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_year", "last_year" FROM "party" WHERE ("party_theme" = 'Spring' OR "party_theme" = 'Teqnology') ORDER BY first_year, party.party_id NULLS LAST;

/*
Gold Result:
('Republican', 'easy')
('author', 'training')
('only', 'serious')
('step', 'recently')
*/

-- Prediction Query
SELECT First_year, Last_year FROM party WHERE Party_Theme = 'Spring' OR Party_Theme = 'Teqnology';

/*
Prediction Result:
('step', 'recently')
('only', 'serious')
('author', 'training')
('Republican', 'easy')
*/
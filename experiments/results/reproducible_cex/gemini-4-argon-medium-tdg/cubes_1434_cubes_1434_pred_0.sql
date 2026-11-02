-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Minister, tie-breaking by Party_ID vs Party_name, and spurious INNER JOINs with region, member, or party_events.
INSERT INTO "region" ("Region_ID", "Region_name", "Date", "Label", "Format", "Catalogue") VALUES (1, 'North', '2020-01-01', 'L1', 'F1', 'C1');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (3, 1, 'Alice', '2021-01-01', '2022-01-01', 'Alpha');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (1, NULL, 'Alice', '2019-01-01', '2020-01-01', 'Zeta');
INSERT INTO "party" ("Party_ID", "Region_ID", "Minister", "Took_office", "Left_office", "Party_name") VALUES (2, 1, 'Bob', '2018-01-01', '2023-01-01', 'Beta');
INSERT INTO "member" ("Member_ID", "Party_ID", "Member_Name", "In_office") VALUES (10, '1', 'John Doe', 'Yes');
INSERT INTO "party_events" ("Event_ID", "Member_in_charge_ID", "Party_ID", "Event_Name") VALUES (100, 10, 1, 'Gala');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT minister, party_name FROM party ORDER BY minister, party.party_id NULLS LAST;

/*
Gold Result:
('Alice', 'Zeta')
('Alice', 'Alpha')
('Bob', 'Beta')
*/

-- Prediction Query
SELECT minister, party_name FROM party ORDER BY took_office DESC, party.party_id NULLS LAST;

/*
Prediction Result:
('Alice', 'Alpha')
('Alice', 'Zeta')
('Bob', 'Beta')
*/
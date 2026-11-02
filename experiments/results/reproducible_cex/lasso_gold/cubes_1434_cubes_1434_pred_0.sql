-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1010, 'Benjamin Stanley', 'spring', 'figure', 'base', 'top');
INSERT INTO "region" ("region_id", "region_name", "date", "label", "format", "catalogue") VALUES (1012, 'Henry Santiago', 'science', 'write', 'result', 'raise');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1011, 1010, 'early', 'trial', 'blood', 'Jesse Flowers');
INSERT INTO "party" ("party_id", "region_id", "minister", "took_office", "left_office", "party_name") VALUES (1013, 1012, NULL, 'politics', 'prove', 'Nicholas Martin');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT minister, party_name FROM party ORDER BY minister, party.party_id NULLS LAST;

/*
Gold Result:
(None, 'Nicholas Martin')
('early', 'Jesse Flowers')
*/

-- Prediction Query
SELECT minister, party_name FROM party ORDER BY took_office DESC, party.party_id NULLS LAST;

/*
Prediction Result:
('early', 'Jesse Flowers')
(None, 'Nicholas Martin')
*/
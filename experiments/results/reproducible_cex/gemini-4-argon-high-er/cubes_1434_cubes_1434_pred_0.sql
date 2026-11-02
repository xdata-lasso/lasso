-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (1, 'North', '2020-01-01', 'L1', 'F1', 'C1');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (1, 1, 'Alice', '2000', '2004', 'Alpha');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (2, 1, 'Bob', '2010', '2014', 'Beta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT minister, party_name FROM party ORDER BY minister, party.party_id NULLS LAST;

/*
Gold Result:
('Alice', 'Alpha')
('Bob', 'Beta')
*/

-- Prediction Query
SELECT minister, party_name FROM party ORDER BY took_office DESC, party.party_id NULLS LAST;

/*
Prediction Result:
('Bob', 'Beta')
('Alice', 'Alpha')
*/
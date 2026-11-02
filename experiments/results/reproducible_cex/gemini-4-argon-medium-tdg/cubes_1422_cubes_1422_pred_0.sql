-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (1, 'North', '2020-01-01', 'L1', 'F1', 'C1');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (1, 1, 'Charlie', '2010', '2014', 'Alpha');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (2, 1, 'Alice', '2014', '2018', 'Beta');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (3, 1, 'Bob', '2018', '2022', 'Gamma');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (1, '1', 'M1', 'Yes');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (2, '1', 'M2', 'No');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (1, 1, 1, 'E1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT minister, took_office, left_office FROM party ORDER BY minister, party.party_id NULLS LAST;

/*
Gold Result:
('Alice', '2014', '2018')
('Bob', '2018', '2022')
('Charlie', '2010', '2014')
*/

-- Prediction Query
SELECT minister, took_office, left_office FROM party ORDER BY left_office, party.party_id NULLS LAST;

/*
Prediction Result:
('Charlie', '2010', '2014')
('Alice', '2014', '2018')
('Bob', '2018', '2022')
*/
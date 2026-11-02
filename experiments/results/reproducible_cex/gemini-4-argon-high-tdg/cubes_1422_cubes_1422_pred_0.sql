-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (10, 'North', '2010-01-01', 'L1', 'F1', 'C1');
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (20, 'South', '2011-01-01', 'L2', 'F2', 'C2');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (3, 10, 'Adams', '2020-05-01', '2022-01-01', 'Zeta Party');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (1, 10, 'Clark', '2018-01-01', '2023-01-01', 'Alpha Party');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (4, 20, 'Baker', '2019-06-01', '2021-06-01', 'Beta Party');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (2, 20, 'Baker', '2021-06-01', '2024-01-01', 'Gamma Party');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (5, 10, 'Adams', '2020-05-01', '2022-01-01', 'Omega Party');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (101, 1, 'Member One', '2018-2020');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (102, 1, 'Member Two', '2020-2023');
INSERT INTO member (Member_ID, Party_ID, Member_Name, In_office) VALUES (103, 2, 'Member Three', '2021-2024');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (1001, 101, 1, 'Annual Gala');
INSERT INTO party_events (Event_ID, Member_in_charge_ID, Party_ID, Event_Name) VALUES (1002, 102, 1, 'Policy Summit');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT minister, took_office, left_office FROM party ORDER BY minister, party.party_id NULLS LAST;

/*
Gold Result:
('Adams', '2020-05-01', '2022-01-01')
('Adams', '2020-05-01', '2022-01-01')
('Baker', '2021-06-01', '2024-01-01')
('Baker', '2019-06-01', '2021-06-01')
('Clark', '2018-01-01', '2023-01-01')
*/

-- Prediction Query
SELECT minister, took_office, left_office FROM party ORDER BY left_office, party.party_id NULLS LAST;

/*
Prediction Result:
('Baker', '2019-06-01', '2021-06-01')
('Adams', '2020-05-01', '2022-01-01')
('Adams', '2020-05-01', '2022-01-01')
('Clark', '2018-01-01', '2023-01-01')
('Baker', '2021-06-01', '2024-01-01')
*/
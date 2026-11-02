-- Schema DDL
CREATE TABLE "region" ("Region_ID" INTEGER PRIMARY KEY, "Region_name" TEXT, "Date" TEXT, "Label" TEXT, "Format" TEXT, "Catalogue" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Region_ID" INTEGER, "Minister" TEXT, "Took_office" TEXT, "Left_office" TEXT, "Party_name" TEXT, FOREIGN KEY ("Region_ID") REFERENCES "region" ("Region_ID"));

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Party_ID" TEXT, "Member_Name" TEXT, "In_office" TEXT, FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

CREATE TABLE "party_events" ("Event_ID" INTEGER PRIMARY KEY, "Member_in_charge_ID" INTEGER, "Party_ID" INTEGER, "Event_Name" TEXT, FOREIGN KEY ("Member_in_charge_ID") REFERENCES "member" ("Member_ID"), FOREIGN KEY ("Party_ID") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO region (Region_ID, Region_name, Date, Label, Format, Catalogue) VALUES (1, 'North', '2020-01-01', 'L1', 'F1', 'C1');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (10, 1, 'Alice', '2018-01-01', '2019-01-01', 'Liberal');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (1, 1, 'Alice', '2018-01-01', '2019-01-01', 'Conservative');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (20, 1, 'Alice', '2019-01-02', '2020-01-01', 'Green');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (5, 1, 'Bob', '2015-05-01', '2018-01-01', 'Labor');
INSERT INTO party (Party_ID, Region_ID, Minister, Took_office, Left_office, Party_name) VALUES (15, 1, 'Charlie', '2020-01-01', '2021-01-01', 'Independent');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT minister, took_office, left_office FROM party ORDER BY minister, party.party_id NULLS LAST;

/*
Gold Result:
('Alice', '2018-01-01', '2019-01-01')
('Alice', '2018-01-01', '2019-01-01')
('Alice', '2019-01-02', '2020-01-01')
('Bob', '2015-05-01', '2018-01-01')
('Charlie', '2020-01-01', '2021-01-01')
*/

-- Prediction Query
SELECT minister, took_office, left_office FROM party ORDER BY left_office, party.party_id NULLS LAST;

/*
Prediction Result:
('Bob', '2015-05-01', '2018-01-01')
('Alice', '2018-01-01', '2019-01-01')
('Alice', '2018-01-01', '2019-01-01')
('Alice', '2019-01-02', '2020-01-01')
('Charlie', '2020-01-01', '2021-01-01')
*/
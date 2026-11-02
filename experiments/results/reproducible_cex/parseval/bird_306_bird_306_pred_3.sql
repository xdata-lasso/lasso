-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't1__6113d1', 't2__c1426f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__6113d1', 't2__c1426f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', '@', 't2__c1426f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', '@', 't2__c1426f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', '@', 't2__c1426f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__6113d1', 't2__c1426f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__6113d1', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', '@', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', '@', 'rwbbp6luhvd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B', 't1__6113d1', 'tti');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__6113d1', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '4');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't1__6113d1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 't1__6113d1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'A', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 't1__6113d1', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', '@', 'gu7v');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', '@', 'e4');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B', 't1__6113d1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id, T2.element FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#';

/*
Gold Result:
('t1__6113d1', None)
('t1__6113d1', 't2__c1426f')
('t1__6113d1', 'tti')
*/

-- Prediction Query
SELECT T1.molecule_id, T2.element FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#';

/*
Prediction Result:
('t1__6113d1', None)
('t1__6113d1', 't2__c1426f')
('t1__6113d1', 't2__c1426f')
('t1__6113d1', 't2__c1426f')
('t1__6113d1', 'tti')
('t1__6113d1', None)
('t1__6113d1', 't2__c1426f')
('t1__6113d1', 't2__c1426f')
('t1__6113d1', 't2__c1426f')
('t1__6113d1', 'tti')
('t1__6113d1', None)
('t1__6113d1', 't2__c1426f')
('t1__6113d1', 't2__c1426f')
('t1__6113d1', 't2__c1426f')
('t1__6113d1', 'tti')
*/
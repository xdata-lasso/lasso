-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__71a092', 'molecule_i_1', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__c50b4d', 'molecule_i_1', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__e3639f', 'TR447', 'e4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'molecule_i_1', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'bnp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'a9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 'TR447', '6nium52zb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__f45972', 'TR447', '5bbp0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 't3__b32dfa', '5k5swwqcgsk9');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR447', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t3__b32dfa', '1');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__c83f4d', 'TR447', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 'TR447', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__382775', 'TR447', 'hsrwbbp');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'TR447', '#');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 'molecule_i_1', 'dposiie5unw');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'TR447', '0t5c4ecigc');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('?', 'molecule_i_1', 'nrqrofqy');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t3__d7e628', 'TR447', 'ytoo3o9hl7');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', '#');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__71a092', 't2__c50b4d', 't2__c83f4d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e3639f', 't2__c50b4d', 't2__c83f4d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't2__c50b4d', 't2__c83f4d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 't2__c50b4d', 't2__c83f4d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_', 't2__c50b4d', 't2__c83f4d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e3639f', 't2__f45972', 't2__c83f4d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__71a092', 't2__f45972', 't2__c83f4d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('@', 'atom_id_3', '@');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.atom_id, T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_type = '#' AND T3.molecule_id = 'TR447';

/*
Gold Result:
('t1__71a092', 't2__c50b4d')
('t2__e3639f', 't2__c50b4d')
('A', 't2__c50b4d')
('G', 't2__c50b4d')
('_', 't2__c50b4d')
('t2__e3639f', 't2__f45972')
('t1__71a092', 't2__f45972')
*/

-- Prediction Query
SELECT DISTINCT c.atom_id, c.atom_id2 FROM connected AS c INNER JOIN bond AS b ON c.bond_id = b.bond_id WHERE b.molecule_id = 'TR041' AND b.bond_type = '#';

/*
Prediction Result:
*/
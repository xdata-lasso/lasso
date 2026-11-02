-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('EAAAAA4', 't1__f84d99', 't1__7bb7fa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__f8d55c', 't1__7bb7fa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('CAAAAA4', 'O', 't1__7bb7fa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GAAAAA4', '_', 't1__7bb7fa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAAAAA4', 't1__f84d99', 't1__7bb7fa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GAAAAAA', 't1__f84d99', 't1__7bb7fa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('4', 't1__f84d99', 't1__7bb7fa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__c27fa9', 'I', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@_AKAA4', '@', 'tti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@@AAAA4', 'B', 'bnp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A@AAAA4', '`', 'mdpos');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__f84d99', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__f8d55c', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('I', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__3c8f8d', 'rwbbp6luhvd');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('`', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND SUBSTRING(T1.atom_id, -1) = '4' AND LENGTH(T1.atom_id) = 7;

/*
Gold Result:
('t1__7bb7fa',)
('tti',)
('bnp',)
('mdpos',)
*/

-- Prediction Query
SELECT COUNT(*) AS atom_count FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+' AND SUBSTRING(T2.atom_id, 7, 1) = '4';

/*
Prediction Result:
(5,)
*/
-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests string matching boundaries: '19' at the start, in the middle, or off-by-one at the end ('190', '18', '219').
-- Gold query should return 1 (only 'A219' ends with '19').
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('M1', '-');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('19_A', 'M1', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A_19_B', 'M1', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A_190', 'M1', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A_18', 'M1', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A219', 'M1', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TARGET', 'M1', 'h');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B1', 'M1', '1');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B2', 'M1', '1');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B3', 'M1', '1');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B4', 'M1', '1');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B5', 'M1', '1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('19_A', 'TARGET', 'B1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A_19_B', 'TARGET', 'B2');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A_190', 'TARGET', 'B3');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A_18', 'TARGET', 'B4');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A219', 'TARGET', 'B5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T.bond_id) FROM connected AS T WHERE SUBSTRING(T.atom_id, -2) = '19';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(connected.bond_id) AS num_connections FROM connected INNER JOIN atom ON connected.atom_id = atom.atom_id WHERE atom.atom_id LIKE 'TR%_19';

/*
Prediction Result:
(0,)
*/
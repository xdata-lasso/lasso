-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests element filtering ('c' vs 'C', 'cl', 'o', NULL) and logical connective (AND vs OR) inside and outside the molecule_id range.
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR005', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR025', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR060', '+');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR005_1', 'TR005', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR025_1', 'TR025', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR025_2', 'TR025', 'C');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR025_3', 'TR025', 'cl');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR025_4', 'TR025', 'o');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR025_5', 'TR025', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR060_1', 'TR060', 'h');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.atom_id FROM atom AS T WHERE T.molecule_id BETWEEN 'TR010' AND 'TR050' AND T.element = 'c';

/*
Gold Result:
('TR025_1',)
*/

-- Prediction Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element LIKE 'C%' AND T2.molecule_id >= 'TR010' AND T2.molecule_id <= 'TR050';

/*
Prediction Result:
('TR025_1',)
('TR025_2',)
('TR025_3',)
*/
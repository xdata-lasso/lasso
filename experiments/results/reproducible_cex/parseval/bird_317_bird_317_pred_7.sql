-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 'mol_a1b77b', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'mol_a1b77b', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'A', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'A', 'gu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'A', 'e4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'A', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'ato_988eb3', 'rwbbp6luhvd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'ato_988eb3', 'tti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'ato_988eb3', 'bnp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'mol_a1b77b', 'mdpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'mol_a1b77b', 'ie5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'mol_a1b77b', 'ato_38bf77');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', '@', 'cl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('B', 'H', '5k5swwqcgs');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('mol_a1b77b', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ato_988eb3', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(CASE WHEN T2.label = '+' AND T1.element = 'cl' THEN T2.molecule_id ELSE NULL END) * 100 / COUNT(T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id;

/*
Gold Result:
(14,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN atom.element = 'cl' THEN 1 ELSE 0 END) AS REAL) * 100.0) / COUNT(molecule.molecule_id) AS percentage FROM molecule JOIN atom ON molecule.molecule_id = atom.molecule_id WHERE molecule.label = '+';

/*
Prediction Result:
(22.22222222222222,)
*/
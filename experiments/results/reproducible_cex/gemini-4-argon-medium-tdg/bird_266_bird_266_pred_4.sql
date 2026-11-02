-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1: Boundary testing (inclusive bounds TR000 and TR030, and just outside bounds)
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR000', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR030', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR00', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR0300', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR031', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T.molecule_id) FROM molecule AS T WHERE T.molecule_id BETWEEN 'TR000' AND 'TR030' AND T.label = '+';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM molecule WHERE label = '+' AND CAST(SUBSTRING(molecule_id, 3) AS INTEGER) BETWEEN 0 AND 30;

/*
Prediction Result:
(3,)
*/
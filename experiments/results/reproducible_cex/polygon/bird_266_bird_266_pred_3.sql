-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR03010', 'TR030-635', 'TR030-635');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR0009', NULL, 'TR030-635');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR00012', 'TR0009196203643531901904', 'TR030-635');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('+11', NULL, 'TR030-635');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR030-635', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR0009196203643531901904', 'TR030-635');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T.molecule_id) FROM molecule AS T WHERE T.molecule_id BETWEEN 'TR000' AND 'TR030' AND T.label = '+';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) AS total_carcinogenic_molecules FROM molecule WHERE label = '+' AND molecule_id BETWEEN 'TR000' AND 'TR030';

/*
Prediction Result:
(0,)
*/
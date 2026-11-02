-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR01013', '--715', '--715');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR00412', '--715', '--715');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR00415', '--715', '-');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('-14', '--715', 'TR01019');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR00412', 'TR00412', '-14');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('--715', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T.molecule_id) FROM bond AS T WHERE T.molecule_id BETWEEN 'TR004' AND 'TR010' AND T.bond_type = '-';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) AS count FROM bond AS b INNER JOIN molecule AS m ON b.molecule_id = m.molecule_id WHERE b.bond_type = '-' AND m.molecule_id BETWEEN 'TR004' AND 'TR010';

/*
Prediction Result:
(0,)
*/
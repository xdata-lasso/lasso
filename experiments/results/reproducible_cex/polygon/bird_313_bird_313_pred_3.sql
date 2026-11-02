-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR00510', 'TR005', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR0019', 'TR00111', 'TR0019');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR00512', 'TR00111', 'TR0019');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR0019', 'TR0019', 'TR00512');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR005', 'TR0019');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR00111', 'TR0019');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T.atom_id) FROM atom AS T WHERE T.molecule_id = 'TR005';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) AS atom_count FROM atom WHERE molecule_id = 'TR001';

/*
Prediction Result:
(0,)
*/
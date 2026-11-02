-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering, NULL handling, column confusion, and spurious INNER JOINs with bond/connected tables (TR186 has no bonds/connections, while TR187 does).
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR186', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR187', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR001', 'TR186');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR186_1', 'TR186', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR186_2', 'TR186', 'o');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR187_1', 'TR187', 'n');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR186', 'TR187', 'h');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_1', 'TR001', 'TR186');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('NULL_ATOM', NULL, 'c');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B_187', 'TR187', '1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR187_1', 'TR186', 'B_187');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.atom_id FROM atom AS T WHERE T.molecule_id = 'TR186';

/*
Gold Result:
('TR186_1',)
('TR186_2',)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR186';

/*
Prediction Result:
('c',)
('o',)
*/
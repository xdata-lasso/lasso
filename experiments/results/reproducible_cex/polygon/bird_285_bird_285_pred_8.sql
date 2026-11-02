-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_10_1134', NULL, 'TR001_10_1133');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_10_1135', NULL, 'TR001_10_1127');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_10_1137', 'TR001_10_1121', 'TR001_10_1130');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_10_1136', 'TR001_10_1122', NULL);
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR001_10_1135', 'TR001_10_1134', 'TR001_10_1137');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR001_10_1134', 'TR001_10_1135', 'TR001_10_1136');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR001_10_1121', 'TR001_10_1135');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR001_10_1122', 'TR001_10_1135');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_id = 'TR001_10_11';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.element, T2.element FROM atom AS T1 INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id INNER JOIN atom AS T2 ON T2.atom_id = T3.atom_id2 WHERE T3.bond_id = 'TR001_10_11';

/*
Prediction Result:
*/
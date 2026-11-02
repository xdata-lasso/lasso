-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('attorney', 'development');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR004_20', 'attorney', 'white');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR004_8', NULL, NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('yes', 'attorney', 'our');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('serious', NULL, NULL);
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR004_20', 'TR004_8', 'yes');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR004_20', 'TR004_20', 'serious');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_type FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T2.atom_id = 'TR004_8' AND T2.atom_id2 = 'TR004_20' OR T2.atom_id2 = 'TR004_8' AND T2.atom_id = 'TR004_20';

/*
Gold Result:
('our',)
*/

-- Prediction Query
SELECT T2.bond_type FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id WHERE T1.atom_id = 'TR004_8' AND T1.atom_id2 = 'TR004_20';

/*
Prediction Result:
*/
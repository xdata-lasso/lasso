-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR02436', 'TR024', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=29', '=31', '=39');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=37', 'TR024', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR02430', '=31', 'TR02438');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR02436', '=29', 'TR02430');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('=29', '=29', '=37');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR024', '=29');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=31', '=29');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR024' AND T2.bond_type = '=';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT DISTINCT a1.element FROM atom AS a1 INNER JOIN connected AS c ON a1.atom_id = c.atom_id INNER JOIN bond AS b ON b.bond_id = c.bond_id WHERE b.bond_type = '=' AND b.molecule_id = 'TR024' UNION SELECT DISTINCT a2.element FROM atom AS a2 INNER JOIN connected AS c ON a2.atom_id = c.atom_id2 INNER JOIN bond AS b ON b.bond_id = c.bond_id WHERE b.bond_type = '=' AND b.molecule_id = 'TR024';

/*
Prediction Result:
('=39',)
*/
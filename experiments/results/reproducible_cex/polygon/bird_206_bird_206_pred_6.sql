-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR004_8_930', 'TR004_8_938', 'TR004_8_940');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR004_8_937', 'TR004_8_938', 'TR004_8_939');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR004_8_9', 'TR004_8_938', 'TR004_8_937');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR004_8_937', 'TR004_8_930', 'TR004_8_9');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR004_8_938', 'TR004_8_937');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR004_8_9';

/*
Gold Result:
('TR004_8_939',)
*/

-- Prediction Query
SELECT DISTINCT atom1.element FROM connected AS conn INNER JOIN atom AS atom1 ON conn.atom_id = atom1.atom_id INNER JOIN atom AS atom2 ON conn.atom_id2 = atom2.atom_id WHERE conn.bond_id = 'TR004_8_9' UNION SELECT DISTINCT atom2.element FROM connected AS conn INNER JOIN atom AS atom1 ON conn.atom_id = atom1.atom_id INNER JOIN atom AS atom2 ON conn.atom_id2 = atom2.atom_id WHERE conn.bond_id = 'TR004_8_9';

/*
Prediction Result:
('TR004_8_939',)
('TR004_8_940',)
*/
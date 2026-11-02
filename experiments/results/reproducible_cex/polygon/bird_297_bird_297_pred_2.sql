-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('c24', 'c22', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('-25', '-23', 'c');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('-17', '-23', 'c26');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('c16', 'c22', '-27');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('c24', '-25', '-17');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('c24', 'c24', 'c16');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('c22', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('-23', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'c' AND T2.label = '-';

/*
Gold Result:
('c24',)
('-25',)
*/

-- Prediction Query
SELECT atom.atom_id FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id INNER JOIN bond ON connected.bond_id = bond.bond_id INNER JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE atom.element = 'c' AND molecule.label = '-';

/*
Prediction Result:
('c24',)
('c24',)
*/
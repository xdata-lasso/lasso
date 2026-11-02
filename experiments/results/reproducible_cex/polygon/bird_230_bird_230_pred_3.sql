-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR06020', 'TR060', 'TR06022');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR06021', 'TR060', 'TR06022');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR06015', 'TR060', 'TR060');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR06014', 'TR06013', 'TR060');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR060', 'TR06023');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR06013', 'TR060');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element, T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR060';

/*
Gold Result:
('TR06022', 'TR06023')
*/

-- Prediction Query
SELECT atom.element, molecule.label FROM molecule INNER JOIN atom ON molecule.molecule_id = atom.molecule_id WHERE molecule.molecule_id = 'TR060';

/*
Prediction Result:
('TR06022', 'TR06023')
('TR06022', 'TR06023')
*/
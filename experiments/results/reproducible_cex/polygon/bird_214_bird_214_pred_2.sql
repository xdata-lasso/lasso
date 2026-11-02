-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Sn25', 'sn18', 'Sn');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Sn17', 'sn18', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('sn20', 'sn18', 'sn18');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Sn19', 'sn18', 'sn18');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('sn18', 'Sn27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 'sn';

/*
Gold Result:
('Sn27',)
*/

-- Prediction Query
SELECT DISTINCT T2.label FROM molecule AS T2 WHERE NOT T2.molecule_id IN (SELECT T1.molecule_id FROM atom AS T1 WHERE T1.element = 'Sn');

/*
Prediction Result:
*/
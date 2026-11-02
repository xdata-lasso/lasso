-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('n', 'n'), ('default2', NULL), ('p', 'p'), ('default1', 'default1'), ('unique_4', 'p'), ('unique_5', 'default2'), ('unique_6', 'n'), ('unique_7', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'unique_7', 'p'), ('n', 'unique_4', 'p'), ('default1', 'unique_7', 'default1'), ('p', 'p', 'p'), ('unique_4', 'default2', 'n'), ('unique_5', 'default1', 'default1'), ('unique_6', 'unique_6', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('n', NULL, 'default2'), ('default1', 'p', 'n'), ('p', 'unique_6', 'default1'), ('default2', 'unique_5', 'p');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('p', 'p', 'p'), ('n', 'n', 'unique_4'), ('default1', 'default2', 'unique_5'), ('default1', 'default1', 'unique_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT b."bond_id" FROM "bond" AS b INNER JOIN "connected" AS c ON b."bond_id" = c."bond_id" INNER JOIN "atom" AS a1 ON c."atom_id" = a1."atom_id" INNER JOIN "atom" AS a2 ON c."atom_id2" = a2."atom_id" WHERE (a1."element" = 'p' OR a2."element" = 'p') AND (a1."element" = 'n' OR a2."element" = 'n');

/*
Prediction Result:
('unique_5',)
*/
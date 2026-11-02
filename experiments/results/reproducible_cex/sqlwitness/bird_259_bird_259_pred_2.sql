-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default2'), ('-', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', '-', 'default2'), ('-', '-', NULL), ('default1', '-', NULL), ('unique_3', 'default2', '-'), ('unique_4', '-', 'default1'), ('unique_5', 'default2', 'default1'), ('unique_6', NULL, NULL), ('unique_7', 'default2', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'default2', 'default1'), ('-', '-', '-');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('-', '-', 'default1'), ('-', 'default1', 'unique_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T.element) FROM (SELECT DISTINCT T2.molecule_id, T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '-') AS T;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT A."element") FROM "connected" AS C INNER JOIN "bond" AS B ON C."bond_id" = B."bond_id" INNER JOIN "atom" AS A ON C."atom_id" = A."atom_id" OR C."atom_id2" = A."atom_id" WHERE B."bond_type" = '-';

/*
Prediction Result:
(0,)
*/
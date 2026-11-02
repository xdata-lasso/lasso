-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests subquery LIMIT 1 placement vs outer query LIMIT 1 when NULL molecule_id strictly has the highest count of '=' bonds.
-- Subquery picks NULL (count 3), which fails the INNER JOIN with molecule, resulting in 0 rows returned.
-- If a mutant joins before applying LIMIT 1, or filters out NULL molecule_id, it will return 'Runner_Up'.
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', 'Runner_Up');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', NULL, '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', NULL, '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', NULL, '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'TR001', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B5', 'TR001', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.label FROM molecule AS T1 INNER JOIN (SELECT T.molecule_id, COUNT(T.bond_type) FROM bond AS T WHERE T.bond_type = '=' GROUP BY T.molecule_id ORDER BY COUNT(T.bond_type) DESC, T.molecule_id NULLS LAST LIMIT 1) AS T2 ON T1.molecule_id = T2.molecule_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT "molecule"."label" FROM "molecule" INNER JOIN "bond" ON "molecule"."molecule_id" = "bond"."molecule_id" WHERE "bond"."bond_type" = '=' GROUP BY "molecule"."molecule_id" ORDER BY COUNT("bond"."bond_id") DESC, "molecule"."label" NULLS LAST LIMIT 1;

/*
Prediction Result:
('Runner_Up',)
*/
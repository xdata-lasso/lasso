-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(COUNT("b"."bond_id") AS REAL) * 100 / (SELECT COUNT("b2"."bond_id") FROM "bond" AS "b2") AS "percentage" FROM "bond" AS "b" INNER JOIN "connected" AS "c1" ON "b"."bond_id" = "c1"."bond_id" INNER JOIN "atom" AS "a1" ON "c1"."atom_id" = "a1"."atom_id" INNER JOIN "connected" AS "c2" ON "b"."bond_id" = "c2"."bond_id" INNER JOIN "atom" AS "a2" ON "c2"."atom_id2" = "a2"."atom_id" GROUP BY "a1"."element", "a2"."element" ORDER BY COUNT("b"."bond_id") DESC, percentage NULLS LAST LIMIT 1;

/*
Prediction Result:
*/
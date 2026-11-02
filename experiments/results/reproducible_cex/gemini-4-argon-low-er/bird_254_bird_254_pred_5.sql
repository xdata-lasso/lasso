-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a1', NULL, 'C');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a2', NULL, 'H');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a3', NULL, 'O');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b1', NULL, '-');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('a1', 'a2', 'b1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('a1', 'a3', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.bond_type = (SELECT T1.bond_type FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id GROUP BY T1.bond_type ORDER BY COUNT(T1.bond_type) DESC, T1.bond_type NULLS LAST LIMIT 1) THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id;

/*
Prediction Result:
(100.0,)
*/
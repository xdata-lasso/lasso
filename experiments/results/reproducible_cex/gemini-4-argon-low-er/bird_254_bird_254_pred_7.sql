-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('m1', '+');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a1', 'm1', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a2', 'm1', 'h');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a3', 'm1', 'o');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b1', 'm1', '-');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b2', 'm1', '-');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('a1', 'a2', 'b1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('a1', 'a3', 'b2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST((SELECT COUNT(*) FROM connected AS c INNER JOIN atom AS a ON c.atom_id = a.atom_id INNER JOIN atom AS a2 ON c.atom_id2 = a2.atom_id WHERE a.element || '-' || a2.element = (SELECT a.element || '-' || a2.element FROM connected AS c INNER JOIN atom AS a ON c.atom_id = a.atom_id INNER JOIN atom AS a2 ON c.atom_id2 = a2.atom_id GROUP BY a.element, a2.element ORDER BY COUNT(*) DESC, a.element || '-' || a2.element NULLS LAST LIMIT 1)) AS REAL) * 100 / (SELECT COUNT(*) FROM connected);

/*
Prediction Result:
(50.0,)
*/
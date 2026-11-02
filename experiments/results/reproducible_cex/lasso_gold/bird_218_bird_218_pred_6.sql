-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('all', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('sense', '+');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('better', 'all', 'discover');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('rate', 'sense', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(DISTINCT CASE WHEN T1.element <> 'f' THEN T2.molecule_id ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN t2.molecule_id IS NULL THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(DISTINCT t1.molecule_id) AS percentage FROM (SELECT DISTINCT molecule_id FROM molecule WHERE label = '+') AS t1 LEFT JOIN (SELECT DISTINCT molecule_id FROM atom WHERE element = 'f') AS t2 ON t1.molecule_id = t2.molecule_id;

/*
Prediction Result:
(100.0,)
*/
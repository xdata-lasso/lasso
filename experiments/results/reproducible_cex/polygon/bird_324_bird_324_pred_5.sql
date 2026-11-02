-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('-34', NULL, '-34');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('-18', '-21', '-34');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('-32', NULL, '-');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('-33', '-21', '-');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('-34', '-34', '-32');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('-19', '-34');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('-21', '-34');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T.bond_type = '-' THEN T.bond_id ELSE NULL END) AS REAL) * 100 / COUNT(T.bond_id) FROM bond AS t;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT (CAST(COUNT(DISTINCT T1.atom_id) AS REAL) * 100.0) / (SELECT COUNT(DISTINCT atom_id) FROM atom) AS percentage FROM (SELECT atom_id FROM connected WHERE bond_id IN (SELECT bond_id FROM bond WHERE bond_type = '-') UNION SELECT atom_id2 FROM connected WHERE bond_id IN (SELECT bond_id FROM bond WHERE bond_type = '-')) AS T1;

/*
Prediction Result:
(50.0,)
*/
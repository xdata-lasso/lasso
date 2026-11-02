-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('c40', '=42', ' = 41');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('c43', ' = 44', 'c');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES (' = 17', ' = 44', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=18', '=42', ' = ');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('c40', 'c40', ' = 17');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('c43', 'c43', '=18');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=42', 'c43');
INSERT INTO "molecule" ("molecule_id", "label") VALUES (' = 44', 'c43');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(DISTINCT CASE WHEN T1.element = 'c' THEN T1.atom_id ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT T1.atom_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '=';

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN a.element = 'c' THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(c.atom_id) AS percentage FROM atom AS a JOIN bond AS b ON a.molecule_id = b.molecule_id JOIN connected AS c ON b.bond_id = c.bond_id WHERE b.bond_type = ' = ';

/*
Prediction Result:
(0.0,)
*/
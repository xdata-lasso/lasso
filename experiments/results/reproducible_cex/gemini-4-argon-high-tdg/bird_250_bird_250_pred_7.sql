-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m3', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m4', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'm1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b4', 'm1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b5', 'm2', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b6', 'm2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b7', 'm2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b8', 'm2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b9', 'm2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b10', 'm2', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b11', 'm2', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b12', 'm3', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b13', 'm3', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b14', 'm4', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b15', 'm4', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b16', 'm4', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b17', 'm4', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b18', 'm4', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.molecule_id FROM (SELECT T3.molecule_id, COUNT(T1.bond_type) FROM bond AS T1 INNER JOIN molecule AS T3 ON T1.molecule_id = T3.molecule_id WHERE T3.label = '+' AND T1.bond_type = '=' GROUP BY T3.molecule_id ORDER BY COUNT(T1.bond_type) DESC, T3.molecule_id NULLS LAST LIMIT 1) AS T;

/*
Gold Result:
('m3',)
*/

-- Prediction Query
SELECT m.molecule_id FROM molecule AS m JOIN bond AS b ON m.molecule_id = b.molecule_id JOIN connected AS c ON b.bond_id = c.bond_id WHERE m.label = '+' AND b.bond_type = '=' GROUP BY m.molecule_id ORDER BY COUNT(b.bond_id) DESC, m.molecule_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/
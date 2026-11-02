-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '+');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'M1', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.molecule_id FROM (SELECT T3.molecule_id, COUNT(T1.bond_type) FROM bond AS T1 INNER JOIN molecule AS T3 ON T1.molecule_id = T3.molecule_id WHERE T3.label = '+' AND T1.bond_type = '=' GROUP BY T3.molecule_id ORDER BY COUNT(T1.bond_type) DESC, T3.molecule_id NULLS LAST LIMIT 1) AS T;

/*
Gold Result:
('M1',)
*/

-- Prediction Query
SELECT m.molecule_id FROM molecule AS m JOIN bond AS b ON m.molecule_id = b.molecule_id JOIN connected AS c ON b.bond_id = c.bond_id WHERE m.label = '+' AND b.bond_type = '=' GROUP BY m.molecule_id ORDER BY COUNT(b.bond_id) DESC, m.molecule_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/
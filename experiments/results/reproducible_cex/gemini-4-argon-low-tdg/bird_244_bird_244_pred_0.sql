-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering on bond_type = '=' vs total bond count, and DESC vs ASC ordering on the count.
-- TR001 has more '=' bonds (2), TR002 has more total bonds (4), TR003 has the fewest '=' bonds (1), TR004 has 0 '=' bonds.
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR002', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR003', '0');
INSERT INTO molecule (molecule_id, label) VALUES ('TR004', 'x');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'TR001', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'TR001', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'TR002', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'TR002', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B5', 'TR002', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B6', 'TR002', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B7', 'TR003', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B8', 'TR004', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B9', 'TR004', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.label FROM molecule AS T1 INNER JOIN (SELECT T.molecule_id, COUNT(T.bond_type) FROM bond AS T WHERE T.bond_type = '=' GROUP BY T.molecule_id ORDER BY COUNT(T.bond_type) DESC, T.molecule_id NULLS LAST LIMIT 1) AS T2 ON T1.molecule_id = T2.molecule_id;

/*
Gold Result:
('+',)
*/

-- Prediction Query
SELECT CASE WHEN T1.label = '+' THEN 'Yes' ELSE 'No' END AS Is_Carcinogenic FROM molecule AS T1 INNER JOIN (SELECT molecule_id, COUNT(bond_id) AS double_bonds FROM bond WHERE bond_type = '=' GROUP BY molecule_id ORDER BY double_bonds DESC, molecule_id NULLS LAST LIMIT 1) AS T2 ON T1.molecule_id = T2.molecule_id;

/*
Prediction Result:
('Yes',)
*/
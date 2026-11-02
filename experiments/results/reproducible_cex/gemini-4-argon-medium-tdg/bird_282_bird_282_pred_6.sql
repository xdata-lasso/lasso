-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR006', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR006_1', 'TR006', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR006_2', 'TR006', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR006_3', 'TR006', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_1', 'TR001', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_2', 'TR001', 'h');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'TR006', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'TR006', '2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR006_1', 'TR006_2', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR006_2', 'TR006_1', 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T.element = 'h' THEN T.atom_id ELSE NULL END) AS REAL) / COUNT(T.atom_id) FROM (SELECT DISTINCT T1.atom_id, T1.element, T1.molecule_id, T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR006') AS T UNION ALL SELECT DISTINCT T3.label FROM (SELECT DISTINCT T1.atom_id, T1.element, T1.molecule_id, T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR006') AS T3;

/*
Gold Result:
(0.3333333333333333,)
('+',)
*/

-- Prediction Query
SELECT COUNT(CASE WHEN a.element = 'h' THEN 1 ELSE NULL END) * 1.0 / COUNT(*) AS hydrogen_ratio, m.label FROM molecule AS m INNER JOIN atom AS a ON m.molecule_id = a.molecule_id WHERE m.molecule_id = 'TR006' GROUP BY m.label;

/*
Prediction Result:
(0.3333333333333333, '+')
*/
-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR006', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR006_1', 'TR006', 'h');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T.element = 'h' THEN T.atom_id ELSE NULL END) AS REAL) / COUNT(T.atom_id) FROM (SELECT DISTINCT T1.atom_id, T1.element, T1.molecule_id, T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR006') AS T UNION ALL SELECT DISTINCT T3.label FROM (SELECT DISTINCT T1.atom_id, T1.element, T1.molecule_id, T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR006') AS T3;

/*
Gold Result:
(1.0,)
('+',)
*/

-- Prediction Query
SELECT COUNT(CASE WHEN a.element = 'h' THEN 1 ELSE NULL END) * 1.0 / COUNT(*) AS hydrogen_ratio, m.label FROM molecule AS m INNER JOIN atom AS a ON m.molecule_id = a.molecule_id WHERE m.molecule_id = 'TR006' GROUP BY m.label;

/*
Prediction Result:
(1.0, '+')
*/
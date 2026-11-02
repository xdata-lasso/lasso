-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default1'), ('f', 'default1'), ('+', 'default1'), ('default2', 'default1'), ('unique_4', '+'), ('unique_5', 'default2'), ('unique_6', '+'), ('unique_7', '+'), ('unique_8', 'f'), ('unique_9', '+'), ('unique_10', '+'), ('unique_11', '+'), ('unique_12', 'default1'), ('unique_13', '+'), ('unique_14', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', '+', 'default2'), ('f', 'unique_4', 'default2'), ('+', 'default2', 'f'), ('default1', 'unique_5', 'f'), ('unique_4', 'unique_8', 'default1'), ('unique_5', 'unique_5', '+'), ('unique_6', 'unique_4', '+'), ('unique_7', 'unique_9', NULL), ('unique_8', 'default1', '+'), ('unique_9', '+', 'default1'), ('unique_10', 'unique_10', NULL), ('unique_11', NULL, 'default2'), ('unique_12', 'unique_8', 'f');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(DISTINCT CASE WHEN T1.element <> 'f' THEN T2.molecule_id ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN a.element = 'f' THEN 1 END) AS REAL) * 100.0 / COUNT(m.molecule_id) AS percentage_with_f FROM molecule AS m JOIN atom AS a ON m.molecule_id = a.molecule_id WHERE m.label = '+';

/*
Prediction Result:
(0.0,)
*/
-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', '+'), ('25', '+'), ('+', '25'), ('21', '25'), ('default2', '21'), ('unique_5', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('25', '+', 'default1'), ('default1', 'default2', 'default1'), ('21', '25', 'default1'), ('default2', 'default1', '+'), ('+', 'default1', NULL), ('unique_5', 'default1', 'default1'), ('unique_6', 'default2', 'default1'), ('unique_7', 'unique_5', 'default2'), ('unique_8', '21', 'default2'), ('unique_9', NULL, 'default2'), ('unique_10', '25', 'default2'), ('unique_11', 'unique_5', '25'), ('unique_12', NULL, '21'), ('unique_13', 'default2', 'default1'), ('unique_14', 'default1', 'default2'), ('unique_15', '21', '25'), ('unique_16', 'default1', 'default2'), ('unique_17', '25', '+'), ('unique_18', 'unique_5', NULL), ('unique_19', 'default2', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE SUBSTRING(T1.atom_id, -2) BETWEEN '21' AND '25' AND T2.label = '+';

/*
Gold Result:
('25',)
*/

-- Prediction Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND CAST(SUBSTRING(T1.atom_id, 7, 2) AS INTEGER) BETWEEN 21 AND 25;

/*
Prediction Result:
*/
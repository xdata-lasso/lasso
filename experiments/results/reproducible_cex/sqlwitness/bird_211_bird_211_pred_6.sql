-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default1'), ('default1', 'default1'), ('-', 'default1'), ('unique_3', 'default1'), ('unique_4', '-'), ('unique_5', 'default2'), ('unique_6', '-'), ('unique_7', 'default2'), ('unique_8', 'default1'), ('unique_9', NULL), ('unique_10', NULL), ('unique_11', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('-', NULL, 'default2'), ('default1', 'unique_7', NULL), ('default2', '-', 'default1'), ('unique_3', 'default1', 'default1'), ('unique_4', 'default1', NULL), ('unique_5', 'default1', 'default1'), ('unique_6', 'default1', 'default1'), ('unique_7', 'unique_11', 'default1'), ('unique_8', 'unique_8', NULL), ('unique_9', 'unique_10', NULL), ('unique_10', '-', NULL), ('unique_11', 'unique_3', NULL), ('unique_12', 'unique_5', 'default1'), ('unique_13', 'unique_7', NULL), ('unique_14', 'unique_5', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'default2', 'default2'), ('-', '-', 'default2'), ('default1', NULL, '-'), ('unique_3', 'default2', NULL), ('unique_4', 'default1', NULL), ('unique_5', 'default2', 'default2'), ('unique_6', '-', '-'), ('unique_7', 'unique_4', NULL), ('unique_8', 'default2', 'default1'), ('unique_9', 'default2', 'default2'), ('unique_10', 'unique_4', '-');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'unique_7', 'unique_5'), ('unique_9', 'unique_10', 'unique_8'), ('unique_9', 'unique_8', 'unique_11'), ('-', 'unique_7', 'unique_13'), ('unique_10', 'unique_6', 'unique_13'), ('unique_10', 'unique_3', 'unique_12'), ('unique_7', 'unique_10', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id WHERE T2.label = '-';

/*
Gold Result:
('unique_10',)
('unique_7',)
*/

-- Prediction Query
SELECT DISTINCT c.atom_id, c.atom_id2 FROM molecule AS m INNER JOIN atom AS a1 ON m.molecule_id = a1.molecule_id INNER JOIN atom AS a2 ON m.molecule_id = a2.molecule_id INNER JOIN connected AS c ON a1.atom_id = c.atom_id AND a2.atom_id = c.atom_id2 WHERE m.label = '-';

/*
Prediction Result:
('unique_7', 'unique_10')
*/
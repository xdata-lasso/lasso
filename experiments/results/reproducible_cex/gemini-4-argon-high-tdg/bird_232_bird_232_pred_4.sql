-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO molecule (molecule_id, label) VALUES ('M00', NULL);
INSERT INTO molecule (molecule_id, label) VALUES ('M01', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('M02', '--');
INSERT INTO molecule (molecule_id, label) VALUES ('M03', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('B10', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M10', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('M20', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('M30', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('M40', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B00', NULL, '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B01', 'M00', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B02', 'M01', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B03', 'M02', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B04', 'M03', '--');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B10', 'M10', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B20', 'M20', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B30', 'M30', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B40', 'M40', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' AND T2.label = '-' ORDER BY T2.molecule_id LIMIT 3;

/*
Gold Result:
('M10',)
('M20',)
('M30',)
*/

-- Prediction Query
SELECT DISTINCT m.molecule_id FROM molecule AS m JOIN bond AS b ON m.molecule_id = b.molecule_id JOIN connected AS c ON b.bond_id = c.bond_id WHERE m.label = '-' AND b.bond_type = '-' ORDER BY m.molecule_id LIMIT 3;

/*
Prediction Result:
*/
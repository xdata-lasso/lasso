-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests COUNT(DISTINCT molecule_id) vs COUNT(atom_id), LIMIT 4 truncation, and ASC vs DESC ordering.
-- Element 'c' has 5 atoms in 1 molecule (COUNT(DISTINCT)=1, COUNT(*)=5).
-- Other elements have 1 atom per molecule across 2 to 6 molecules.
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m3', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m4', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m5', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m6', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a6', 'm1', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a7', 'm2', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a8', 'm1', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a9', 'm2', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a10', 'm3', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a11', 'm1', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a12', 'm2', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a13', 'm3', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a14', 'm4', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a15', 'm1', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a16', 'm2', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a17', 'm3', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a18', 'm4', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a19', 'm5', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a20', 'm1', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a21', 'm2', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a22', 'm3', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a23', 'm4', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a24', 'm5', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a25', 'm6', 'p');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.element FROM (SELECT T1.element, COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '-' GROUP BY T1.element ORDER BY COUNT(DISTINCT T1.molecule_id) ASC, T1.element NULLS LAST LIMIT 4) AS t;

/*
Gold Result:
('c',)
('h',)
('o',)
('n',)
*/

-- Prediction Query
SELECT element FROM atom WHERE molecule_id IN (SELECT molecule_id FROM molecule WHERE label = '-') GROUP BY element ORDER BY COUNT(element), element NULLS LAST LIMIT 1;

/*
Prediction Result:
('h',)
*/
-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate preservation (SELECT vs SELECT DISTINCT) and IN-subquery vs INNER JOIN multiplicity differences.
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm1', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm1', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'm1', 'c');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm1', '2');
-- b1 has ONE 'n' atom (a1) in atom_id, and TWO 'p' atoms (a3, a4) in atom_id.
-- Reference Query (using IN) outputs 'b1' ONCE. An un-deduplicated INNER JOIN mutant outputs 'b1' TWICE.
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a3', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a1', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a4', 'a1', 'b1');
-- b2 has TWO 'n' atoms (a1, a2) in atom_id, and ONE 'p' atom (a3) in atom_id.
-- Reference Query outputs 'b2' TWICE. A SELECT DISTINCT mutant outputs 'b2' ONCE.
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a5', 'b2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a2', 'a5', 'b2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a5', 'b2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
('b1',)
('b2',)
('b2',)
*/

-- Prediction Query
SELECT bond.bond_id FROM atom AS atom1 INNER JOIN connected AS connected1 ON atom1.atom_id = connected1.atom_id INNER JOIN bond ON connected1.bond_id = bond.bond_id WHERE atom1.element = 'p' AND connected1.atom_id2 IN (SELECT atom2.atom_id FROM atom AS atom2 WHERE atom2.element = 'n');

/*
Prediction Result:
('b1',)
('b1',)
*/
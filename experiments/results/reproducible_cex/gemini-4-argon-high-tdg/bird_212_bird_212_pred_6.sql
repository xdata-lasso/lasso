-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m3', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m4', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m5', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m6', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m7', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m8', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m9', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m10', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m11', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m12', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm1', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm1', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'm1', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a6', 'm1', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a7', 'm1', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a8', 'm1', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a9', 'm1', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a10', 'm1', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a11', 'm1', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a12', 'm1', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a13', 'm1', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a14', 'm1', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a15', 'm2', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a16', 'm2', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a17', 'm2', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a18', 'm1', 'f');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a19', 'm2', 'f');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a20', 'm3', 'f');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a21', 'm1', 'i');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a22', 'm2', 'i');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a23', 'm3', 'i');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a24', 'm4', 'i');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a25', 'm1', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a26', 'm2', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a27', 'm3', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a28', 'm4', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a29', 'm5', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a30', 'm1', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a31', 'm2', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a32', 'm3', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a33', 'm4', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a34', 'm5', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a35', 'm6', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a36', 'm7', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a37', 'm7', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a38', 'm8', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a39', 'm9', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a40', 'm10', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a41', 'm11', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a42', 'm12', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a43', 'm7', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a44', 'm8', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a45', 'm9', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a46', 'm10', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a47', 'm11', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a48', 'm12', 'cl');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.element FROM (SELECT T1.element, COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '-' GROUP BY T1.element ORDER BY COUNT(DISTINCT T1.molecule_id) ASC, T1.element NULLS LAST LIMIT 4) AS t;

/*
Gold Result:
('br',)
('cl',)
('f',)
('i',)
*/

-- Prediction Query
SELECT element FROM (SELECT element, COUNT(*) AS element_count FROM (SELECT * FROM molecule WHERE label = '-') AS m JOIN atom ON m.molecule_id = atom.molecule_id GROUP BY element) AS element_counts ORDER BY element_count ASC, element NULLS LAST LIMIT 1;

/*
Prediction Result:
('f',)
*/
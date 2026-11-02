-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__8ab5ee', 'TR006', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__ad5b01', 'TR006', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'TR006', 'hsrwbbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'TR006', 'luhvdltti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 'TR006', 'bnp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'TR006', 'dpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'TR006', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'TR006', 'ecigce376n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'TR006', 'um5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'TR006', 'fqyp5s5bbp0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'TR006', 'tliqa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'TR006', 'i7z');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__9bf702', 'TR006', 'au2dwy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'TR006', '3pyu78d99r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'TR006', '0b4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'TR006', 'p5qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'TR006', 'z0f8jegd21vy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 't1__190e18', '5hncpr');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR006', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__ba9c00', '9uxj4hwbdvl');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__190e18', 'h2gn');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__886d1f', 'TR006', 'u7vfe4hria2y');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('"', 'TR006', '5u');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('a', 'TR006', 'klfa9000t');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('!', 'TR006', 'u');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'TR006', 'rqro');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('$', 'TR006', 'ytoo3o9hl7');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 'TR006', 'ex1');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8ab5ee', 't1__8ab5ee', 't2__886d1f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8ab5ee', 'atom_id_3', 't2__886d1f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 't1__ad5b01', '"');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 'atom_id_7', 'a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'O', '!');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_11', '"');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_7', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'Q', '$');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_12', 'Q');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9bf702', 'Q', 't2__886d1f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9bf702', 'atom_id_14', 't2__886d1f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9bf702', 'atom_id_3', 't2__886d1f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9bf702', 'atom_id_15', 't2__886d1f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9bf702', 'atom_id_16', 't2__886d1f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9bf702', 'I', 't2__886d1f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9bf702', 'atom_id_12', 't2__886d1f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9bf702', 'atom_id_17', 't2__886d1f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8ab5ee', 't1__ad5b01', 't2__886d1f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8ab5ee', 'I', 't2__886d1f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__9bf702', 'atom_id_7', 'a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8ab5ee', 'atom_id_18', 't2__886d1f');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__8ab5ee', 'Q', 't2__886d1f');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.molecule_id = 'TR006' ORDER BY T2.bond_id LIMIT 2;

/*
Gold Result:
('!',)
('"',)
*/

-- Prediction Query
SELECT DISTINCT bond_type FROM bond WHERE molecule_id = 'TR006' ORDER BY bond_type LIMIT 2;

/*
Prediction Result:
('5u',)
('ex1',)
*/
-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__c0c658', 't1__a0d184', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__fb154e', 't1__f6014d', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES (')', 'f', 'e4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('(', 't1__a0d184', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('"', 'b', 'hvdlttilbnpr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('!', 'molecule_i_2', 'dposiie5unw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('1', ',', 'c4ecigce');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('0', ',', '6nium52zb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('c', 't1__a0d184', 'uo4nrqrofqy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('%', 't1__f6014d', '5s5b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__a0d184', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 't1__a0d184', '02eutliqa11r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('D', 't1__f6014d', 'ytoo3o9');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__a0d184', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_2', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__f6014d', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('S', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('f', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('!', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('b', 'uzhsrwbbp6lu');

INSERT INTO "molecule" ("molecule_id", "label") VALUES (',', 'klfa9000t');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.molecule_id FROM (SELECT T2.molecule_id, COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' GROUP BY T2.molecule_id ORDER BY COUNT(T1.atom_id) DESC, T2.molecule_id NULLS LAST LIMIT 1) AS t;

/*
Gold Result:
('t1__a0d184',)
*/

-- Prediction Query
SELECT molecule.label FROM molecule INNER JOIN atom ON molecule.molecule_id = atom.molecule_id WHERE molecule.label = '+' GROUP BY molecule.molecule_id ORDER BY COUNT(atom.atom_id) DESC, molecule.label NULLS LAST LIMIT 1;

/*
Prediction Result:
('+',)
*/
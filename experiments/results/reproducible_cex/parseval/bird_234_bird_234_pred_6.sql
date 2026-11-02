-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_QPIO?4', 'TR009', 'pgu7vfe4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR009_12', 'TR009', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA?7X', 'TR009', 'dlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GA__K', 'TR009', 'unw6klfa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('''qWK_?B', 'TR009', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA_?g', 'TR009', '76nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GA?yf', 'TR009', 'u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAOK?', 'TR009', 'nrqrofqy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Sq?_?o3', 'TR009', 's5bbp02e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAW?H', 'TR009', 'liqa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OAj??C', 'TR009', 'yytoo');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAIOq', 'TR009', '9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OA?AO', 'TR009', 'lex');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('''q??_Ka', 'TR009', 'ji7zwau2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OA-|?', 'TR009', '9rljsl0b4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__862a8f', 't2__e1277c', 'p5qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__a05ad6', 't2__e1277c', 'x58pz0f8je');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA@?U', 'TR009', 'lph2gn');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR009', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__e1277c', 'dwyrq13pyu78');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__5032a3', 'TR009', '9n8');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'TR009', 'uzhsrwbbp6lu');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'TR009', 'nprmdposii');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__660914', 'TR009', 'd21vy9uxj4hw');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_QPIO?4', 'TR009_12', 't1__5032a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA?7X', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GA__K', 'TR009_12', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('''qWK_?B', 'TR009_12', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA_?g', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GA?yf', 'TR009_12', 't1__5032a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AAOK?', 't1__5032a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Sq?_?o3', 'TR009_12', 't1__5032a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AAW?H', 't1__5032a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAj??C', 'TR009_12', 't1__5032a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AAIOq', 't1__5032a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA?AO', 'TR009_12', 't1__5032a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('''q??_Ka', 'TR009_12', 't1__5032a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA-|?', 'TR009_12', 't1__5032a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__862a8f', 't1__a05ad6', 't1__5032a3');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA@?U', 't1__5032a3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.bond_id) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.molecule_id = 'TR009' AND T2.atom_id = T1.molecule_id || '_1' AND T2.atom_id2 = T1.molecule_id || '_2';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.bond_id) AS bond_count FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id WHERE T2.molecule_id = 'TR009' AND (T1.atom_id = 'TR009_12' OR T1.atom_id2 = 'TR009_12');

/*
Prediction Result:
(2,)
*/
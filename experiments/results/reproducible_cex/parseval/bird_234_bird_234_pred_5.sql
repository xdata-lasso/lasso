-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OA1''O', 'TR009', 'pgu7vfe4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR009_12', 'TR009', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAA >', 'TR009', 'dlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G!CX#_', 'TR009', 'unw6klfa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_q5/_W', 'TR009', '76nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?q?C__', 'TR009', 'u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G!?I?)', 'TR009', 'nrqrofqy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAAI?`', 'TR009', 's5bbp02e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O!omGK', 'TR009', 'liqa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?q`/[oB', 'TR009', 'yytoo');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OA!oJ', 'TR009', '9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA?I''', 'TR009', 'lex');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_QE?Q?Y', 'TR009', 'ji7zwau2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('IAg?_?', 'TR009', 'yrq13p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA_KQO?', 'TR009', 'sl0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__9591a5', 'TR009', 'yp5qi2rk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__df827a', 'TR009', 'vqx58pz0f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G!G/_A', 't2__9b13c0', 'y9uxj4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I!%C_ ', 'TR009', 'bdvlph');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR009', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__9b13c0', 'u78d99r');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__8cba1a', 'TR009', '9n8');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'TR009', 'uzhsrwbbp6lu');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'TR009', 'nprmdposii');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'TR009', '00t5c4ecigc');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__5c7995', 'TR009', 'd2');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA1''O', 'TR009_12', 't1__8cba1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AAA >', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G!CX#_', 'TR009_12', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_q5/_W', 'TR009_12', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?q?C__', 'TR009_12', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G!?I?)', 'TR009_12', 't1__8cba1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AAAI?`', 't1__8cba1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O!omGK', 'TR009_12', 't1__8cba1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?q`/[oB', 'TR009_12', 't1__8cba1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA!oJ', 'TR009_12', 't1__8cba1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA?I''', 't1__8cba1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_QE?Q?Y', 'TR009_12', 't1__8cba1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('IAg?_?', 'TR009_12', 't1__8cba1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA_KQO?', 't1__8cba1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__9591a5', 't1__df827a', 't1__8cba1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G!G/_A', 'TR009_12', 't1__8cba1a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('I!%C_ ', 'TR009_12', 't1__8cba1a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.bond_id) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.molecule_id = 'TR009' AND T2.atom_id = T1.molecule_id || '_1' AND T2.atom_id2 = T1.molecule_id || '_2';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.bond_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id WHERE T2.molecule_id = 'TR009' AND (T1.atom_id = 'TR009_12' OR T1.atom_id2 = 'TR009_12');

/*
Prediction Result:
(16,)
*/
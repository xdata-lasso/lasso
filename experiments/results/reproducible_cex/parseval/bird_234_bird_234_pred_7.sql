-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OA''/C', 'TR009', 'pgu7vfe4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR009_12', 'TR009', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAP_?', 'TR009', 'dlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O!?c77', 'TR009', 'unw6klfa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?qA____', 'TR009', '76nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA{_/', 'TR009', 'u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OA?_3', 'TR009', 'nrqrofqy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA?1W', 'TR009', 's5bbp02e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA5Q/O', 'TR009', 'liqa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA?+G', 'TR009', 'yytoo');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OAG??', 'TR009', '9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I!g?YQ', 'TR009', 'lex');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_QAbO_', 'TR009', 'ji7zwau2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA??m', 'TR009', 'yrq13p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G!?#K?', 'TR009', 'sl0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('c_s_36e74e', 'TR009', 'yp5qi2rk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('c_s_fef4a2', 'TR009', 'vqx58pz0f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O!_!C?', 'b_s_35446d', 'y9uxj4');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR009', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('b_s_35446d', 'u78d99r');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('c_s_a30271', 'TR009', '9n8');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'TR009', 'uzhsrwbbp6lu');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('E', 'TR009', 'nprmdposii');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'TR009', '00t5c4ecigc');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b_s_fe9609', 'TR009', 'd2');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA''/C', 'TR009_12', 'c_s_a30271');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AAP_?', 'E');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O!?c77', 'TR009_12', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?qA____', 'TR009_12', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA{_/', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA?_3', 'TR009_12', 'c_s_a30271');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA?1W', 'c_s_a30271');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA5Q/O', 'c_s_a30271');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA?+G', 'c_s_a30271');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAG??', 'TR009_12', 'c_s_a30271');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('I!g?YQ', 'TR009_12', 'c_s_a30271');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_QAbO_', 'TR009_12', 'c_s_a30271');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA??m', 'c_s_a30271');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G!?#K?', 'TR009_12', 'c_s_a30271');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('c_s_36e74e', 'c_s_fef4a2', 'c_s_a30271');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O!_!C?', 'TR009_12', 'c_s_a30271');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.bond_id) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.molecule_id = 'TR009' AND T2.atom_id = T1.molecule_id || '_1' AND T2.atom_id2 = T1.molecule_id || '_2';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT c.bond_id) FROM connected AS c JOIN bond AS b ON c.bond_id = b.bond_id WHERE b.molecule_id = 'TR009' AND (c.atom_id = 'TR009_12' OR c.atom_id2 = 'TR009_12');

/*
Prediction Result:
(3,)
*/
-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR009_12', 'TR009', 'pgu7vfe4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAG=G', 'TR009', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('"q?o?M7', 'TR009', 'dlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA?0]', 'TR009', 'unw6klfa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OAG;Yo', 'TR009', '76nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OAOD''', 'TR009', 'u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OA7?h', 'TR009', '02eu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_q#We?', 'TR009', 'iqa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O!?_3#', 'TR009', 'ryytoo3');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OA{cO', 'TR009', 'hl72klex1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GA%!y', 'TR009', 'i7z');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES (')qOOW?Q', 'TR009', 'au2dwyrq13');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G!?_O;', 'TR009', 'u78d99r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA''?[', 'TR009', 'sl0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GAHLGO', 'bon_7b321a', 'p5qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_5b0ad5', 'bon_7b321a', 'x58pz0f8je');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_d86f9c', 'TR009', 'd21vy9uxj4hw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAAA?', 'bon_7b321a', 'ph2');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR009', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('bon_7b321a', '4');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bon_03afe0', 'TR009', '9n8');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'TR009', 'uzhsrwbbp6lu');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'TR009', 'nprmdposii');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'TR009', '00t5c4ecigc');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('I', 'TR009', 'nrqrofqy');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('con_7a0b2d', 'TR009', '5s5b');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AAG=G', 'bon_03afe0');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('"q?o?M7', 'TR009_12', 'G');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA?0]', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAG;Yo', 'TR009_12', 'O');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAOD''', 'TR009_12', 'I');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA7?h', 'TR009_12', 'con_7a0b2d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('_q#We?', 'TR009_12', 'con_7a0b2d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O!?_3#', 'TR009_12', 'con_7a0b2d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA{cO', 'TR009_12', 'con_7a0b2d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GA%!y', 'TR009_12', 'con_7a0b2d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES (')qOOW?Q', 'TR009_12', 'con_7a0b2d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G!?_O;', 'TR009_12', 'con_7a0b2d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA''?[', 'con_7a0b2d');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GAHLGO', 'TR009_12', 'bon_03afe0');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_5b0ad5', 'con_d86f9c', 'bon_03afe0');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AAAA?', 'bon_03afe0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.bond_id) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.molecule_id = 'TR009' AND T2.atom_id = T1.molecule_id || '_1' AND T2.atom_id2 = T1.molecule_id || '_2';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM bond JOIN connected ON bond.bond_id = connected.bond_id WHERE bond.molecule_id = 'TR009' AND (connected.atom_id = 'TR009_12' OR connected.atom_id2 = 'TR009_12');

/*
Prediction Result:
(15,)
*/
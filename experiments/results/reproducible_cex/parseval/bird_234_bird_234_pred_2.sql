-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('IA)aI', 'TR009', 'pgu7vfe4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR009_12', 'TR009', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GA.-G', 'TR009', 'dlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GA/G_', 'TR009', 'unw6klfa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I!O50?', 'TR009', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OAWAo', 'TR009', '76nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GA?EC', 'TR009', 'p5s5bbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?q??On/', 'TR009', '2eutliqa11r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G!G[Io', 'TR009', 'ytoo3o9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('/q@?0#', 'TR009', 'lex');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G!O_!<', 'TR009', 'ji7zwau2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA$C`', 'TR009', 'yrq13p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('1qw??Y"', 'TR009', '78d99r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O!h\I_', 'TR009', 'sl0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Sq?O?uO', 't1__cb962c', 'p5qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__ccc96f', 't1__cb962c', 'x58pz0f8je');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__91579f', 'TR009', 'd21vy9uxj4hw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AAA_S', 'TR009', 'lph2gn');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR009', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__cb962c', '4');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__0c3c71', 'TR009', '9n8');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'TR009', 'uzhsrwbbp6lu');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'TR009', 'nprmdposii');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__f25d32', 'TR009', 'zbuo4nrqrof');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('IA)aI', 'TR009_12', 't1__0c3c71');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GA.-G', 'TR009_12', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GA/G_', 'TR009_12', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('I!O50?', 'TR009_12', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OAWAo', 'TR009_12', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GA?EC', 'TR009_12', 't2__f25d32');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?q??On/', 'TR009_12', 't2__f25d32');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G!G[Io', 'TR009_12', 't2__f25d32');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('/q@?0#', 'TR009_12', 't2__f25d32');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G!O_!<', 'TR009_12', 't2__f25d32');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA$C`', 't2__f25d32');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('1qw??Y"', 'TR009_12', 't2__f25d32');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O!h\I_', 'TR009_12', 't2__f25d32');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Sq?O?uO', 'TR009_12', 't1__0c3c71');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ccc96f', 't2__91579f', 't1__0c3c71');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AAA_S', 't1__0c3c71');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.bond_id) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.molecule_id = 'TR009' AND T2.atom_id = T1.molecule_id || '_1' AND T2.atom_id2 = T1.molecule_id || '_2';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.bond_id) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.molecule_id = 'TR009' AND (T2.atom_id = 'TR009_12' OR T2.atom_id2 = 'TR009_12');

/*
Prediction Result:
(15,)
*/
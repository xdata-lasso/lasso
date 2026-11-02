-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GA*Q?', 'TR009', 'pgu7vfe4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR009_12', 'TR009', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OACW_O', 'TR009', 'dlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('GAKOg', 'TR009', '6klfa9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA?Z1o', 'TR009', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G!/O_S', 'TR009', '76nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O!wKG)', 'TR009', 'p5s5bbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G!_/?Y', 'TR009', '2eutliqa11r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G!P?C/', 'TR009', 'ytoo3o9hl7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O!QqC_', 'TR009', 'lex');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C!t?O_', 'TR009', 'ji7zwau2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('CAV _', 'TR009', 'yrq13p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA/g_', 'TR009', '78d99r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('AA_?_', 'TR009', 'sl0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('OA??Z', 'bon_e6590e', 'p5qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_1fd880', 'bon_e6590e', 'x58pz0f8je');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_b27371', 'TR009', 'd21vy9uxj4hw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Sq___]F', 'TR009', 'lph2gn');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR009', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('bon_e6590e', '4');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bon_06031a', 'TR009', '9n8');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 'TR009', 'uzhsrwbbp6lu');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'TR009', 'nprmdposii');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 'TR009', '5u');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('con_fb7a4c', 'TR009', 'zbuo4nrqrof');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GA*Q?', 'TR009_12', 'bon_06031a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OACW_O', 'TR009_12', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('GAKOg', 'TR009_12', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA?Z1o', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G!/O_S', 'TR009_12', 'A');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O!wKG)', 'TR009_12', 'con_fb7a4c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G!_/?Y', 'TR009_12', 'con_fb7a4c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G!P?C/', 'TR009_12', 'con_fb7a4c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O!QqC_', 'TR009_12', 'con_fb7a4c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C!t?O_', 'TR009_12', 'con_fb7a4c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('CAV _', 'TR009_12', 'con_fb7a4c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA/g_', 'con_fb7a4c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'AA_?_', 'con_fb7a4c');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('OA??Z', 'TR009_12', 'bon_06031a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_1fd880', 'con_b27371', 'bon_06031a');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Sq___]F', 'TR009_12', 'bon_06031a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.bond_id) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.molecule_id = 'TR009' AND T2.atom_id = T1.molecule_id || '_1' AND T2.atom_id2 = T1.molecule_id || '_2';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT("bond"."bond_id") FROM "bond" INNER JOIN "connected" ON "bond"."bond_id" = "connected"."bond_id" WHERE "bond"."molecule_id" = 'TR009' AND ("connected"."atom_id" = 'TR009_12' OR "connected"."atom_id2" = 'TR009_12');

/*
Prediction Result:
(15,)
*/
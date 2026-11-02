-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__b98520', 't1__a60aad', 't1__4f9557');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__ecec8b', 't1__f81cce', 't1__4f9557');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 't1__f81cce', 'vfe4hria2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 't1__f81cce', 'mdpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 't1__a60aad', 't1__4f9557');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 't1__f81cce', 't1__4f9557');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__a60aad', 'unw6klfa');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 't1__a60aad', 'e376nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't1__a60aad', 't1__4f9557');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', 't1__f81cce', 't1__4f9557');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'G', 'b');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'Q', '2eutliqa11r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__f81cce', 't1__4f9557');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'G', 'oo3o9hl72kle');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't1__f81cce', '7zw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__b5e601', 't1__a60aad', 't1__4f9557');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't1__f81cce', 't1__4f9557');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'Q', 'q13py');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', '_', 'd99rljsl0');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 't1__f81cce', 't1__4f9557');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'Q', 'p5qi2rkf9v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 't1__f81cce', 't1__4f9557');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'G', 'z0f8jegd21');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 'G', '9uxj4hwbdvl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', '_', '2g');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 't1__a60aad', 'x5hncprjtu0');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__a60aad', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__f81cce', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'puzhsrw');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', 'b');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 'p6luhvdlttil');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '0t5c4ec');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', 'rqrofqyp5s');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_2', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_3', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_4', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_5', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_6', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_7', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_8', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_9', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_10', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_11', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_12', 'A', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_13', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_14', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_15', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_16', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_17', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_18', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_19', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_20', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_21', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_22', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_23', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_24', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_25', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_26', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_27', 't1__a60aad', 't2__713fee');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_28', 't1__a60aad', 't2__c58142');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_29', 't1__a60aad', '=');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_30', 't1__a60aad', '=');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 't1__b98520', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 'atom_id_3', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 'atom_id_4', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 't1__ecec8b', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'G', 'bond_id_5');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_4', 'bond_id_6');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 'atom_id_8', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 'A', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_5', 'bond_id_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_8', 'bond_id_4');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 'atom_id_11', 'bond_id_12');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 'atom_id_12', 'bond_id_12');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'A', 'bond_id_10');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_14', 'bond_id_5');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 'O', 'bond_id_12');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 'atom_id_15', 'bond_id_16');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__b5e601', 't1__b98520', 'bond_id_11');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__b5e601', 'atom_id_15', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 'atom_id_18', 'bond_id_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 'atom_id_19', 'bond_id_17');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__b5e601', 'atom_id_21', 'bond_id_16');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__b5e601', '_', 'bond_id_20');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 'atom_id_21', 'bond_id_12');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 't3__b5e601', 'bond_id_18');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__b5e601', 'atom_id_23', 'bond_id_8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__b5e601', 'atom_id_11', 'bond_id_13');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 'atom_id_24', 'bond_id_19');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 'atom_id_25', 'bond_id_23');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__b5e601', 'A', 'bond_id_2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', '_', 'bond_id_12');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__b98520', 'atom_id_26', 'bond_id_9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id WHERE T2.bond_type = '=';

/*
Gold Result:
('unw6klfa',)
('t1__4f9557',)
*/

-- Prediction Query
SELECT DISTINCT a1."element" FROM "connected" AS c INNER JOIN "bond" AS b ON c."bond_id" = b."bond_id" INNER JOIN "atom" AS a1 ON c."atom_id" = a1."atom_id" WHERE b."bond_type" = '=' UNION SELECT DISTINCT a2."element" FROM "connected" AS c INNER JOIN "bond" AS b ON c."bond_id" = b."bond_id" INNER JOIN "atom" AS a2 ON c."atom_id2" = a2."atom_id" WHERE b."bond_type" = '=';

/*
Prediction Result:
('2eutliqa11r',)
('2g',)
('7zw',)
('9uxj4hwbdvl',)
('b',)
('d99rljsl0',)
('e376nium52',)
('mdpos',)
('oo3o9hl72kle',)
('p5qi2rkf9v',)
('q13py',)
('t1__4f9557',)
('unw6klfa',)
('vfe4hria2',)
('x5hncprjtu0',)
('z0f8jegd21',)
*/
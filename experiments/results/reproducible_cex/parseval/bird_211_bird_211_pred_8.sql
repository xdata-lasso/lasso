-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__45989b', 't1__4fa08a', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__f8ff19', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'A', 'lbn');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 't1__f8ff19', 'dposiie5unw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 't1__4fa08a', 'klfa9000t');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('?', 'C', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 't1__4fa08a', 'e376nium52');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 't1__4fa08a', 'uo4nrqrofqy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__f8ff19', 's5bbp02e');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'A', 'ytoo3o9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 't1__4fa08a', 'x14ji7zwau2d');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 'C', '3pyu78d99r');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'A', '0b4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'C', 'i2rkf');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'C', 'pz0f8jegd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'A', '9uxj4hw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'A', 'ph2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 't1__4fa08a', 'wnqcx');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 't1__f8ff19', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'A', '0dz79f');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'A', 'n2f3dqv0g');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'O', 'ozk3zbily');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__9b9102', 't1__f8ff19', 'ah0f8jsww');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 't1__4fa08a', '72fxa7ryfd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 't2__3b8629', '16nijjai5dh');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__4fa08a', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__f8ff19', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', 'rwbbp6luhvd');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__3b8629', 'kn6vc');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 't1__f8ff19', 'gu7v');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 't1__45989b', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_2', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_3', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_4', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', '@', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', '?', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_7', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_8', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', '?', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 'atom_id_3', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', '@', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_10', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', 'atom_id_2', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('?', 'A', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_11', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', '?', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_12', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_13', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_14', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'A', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_15', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_16', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_17', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_18', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_19', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_20', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_21', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_22', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__9b9102', '?', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_24', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__45989b', 'atom_id_25', 'bond_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id WHERE T2.label = '-';

/*
Gold Result:
('t1__45989b',)
*/

-- Prediction Query
SELECT DISTINCT "connected"."atom_id", "connected"."atom_id2" FROM "connected" INNER JOIN "bond" ON "connected"."bond_id" = "bond"."bond_id" INNER JOIN "molecule" ON "bond"."molecule_id" = "molecule"."molecule_id" WHERE "molecule"."label" = '-';

/*
Prediction Result:
*/
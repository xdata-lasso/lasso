-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__806281', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t1__10bf46', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__e2b1c2', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 'molecule_i_1', 'p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t3__ad0e40', 'molecule_i_1', 'hria2ypu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'molecule_i_1', 'wbbp6luhvdlt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G', 'molecule_i_1', 'posiie5unw6k');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'molecule_i_1', '00t5c4ecigc');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('I', 'molecule_i_1', 'u');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'molecule_i_1', 'rqrofqyp5s');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__58398d', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 'molecule_i_1', 'liqa1');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 'molecule_i_1', 'oo3o9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 'molecule_i_1', '72klex14ji7z');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 'molecule_i_1', 'yrq13p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_17', 'molecule_i_1', 'jsl');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 'molecule_i_1', 'p5qi2rk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 'molecule_i_1', 'pz0f8jegd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 'molecule_i_1', 'y9uxj4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 'molecule_i_1', 'ph2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 'molecule_i_1', 'nqcx5h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 'molecule_i_1', 'rjtu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 'molecule_i_1', 'dqv0gcb98ozk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 'molecule_i_1', 'yrk');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 'molecule_i_1', '6vck6ah0f8js');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__10a735', 'molecule_i_1', 'u7');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__806281', 'atom_id_1', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__806281', 't3__e2b1c2', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 't1__806281', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__ad0e40', 'atom_id_1', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A', 't3__e2b1c2', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 't1__10bf46', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__806281', 't3__ad0e40', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('C', 't1__10bf46', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__806281', 't1__10bf46', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G', 't3__e2b1c2', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 't1__10bf46', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 'G', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__806281', 'C', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O', 'atom_id_1', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('I', 'atom_id_1', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 'atom_id_11', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__58398d', 't1__806281', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__58398d', 'atom_id_1', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 't2__58398d', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__806281', 'I', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 'atom_id_13', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 'A', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__806281', 'atom_id_14', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 'atom_id_15', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 'C', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__58398d', 't2__58398d', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__58398d', 'G', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 'atom_id_16', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__806281', 'atom_id_17', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 'atom_id_14', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 'atom_id_18', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__58398d', 'O', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__58398d', 'atom_id_19', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 'atom_id_20', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__806281', 't1__806281', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 'atom_id_21', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__806281', 'atom_id_22', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 'atom_id_23', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__58398d', 'atom_id_14', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__58398d', 'atom_id_13', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__806281', 'O', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 'atom_id_24', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t1__806281', 'atom_id_25', 't2__10a735');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t3__e2b1c2', 'atom_id_26', 't2__10a735');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
('t2__10a735',)
*/

-- Prediction Query
SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T1 ON T1.atom_id = T3.atom_id INNER JOIN atom AS T2 ON T2.atom_id = T3.atom_id2 WHERE (T1.element = 'P' AND T2.element = 'N') OR (T1.element = 'N' AND T2.element = 'P');

/*
Prediction Result:
*/
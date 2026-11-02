-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__5c8234', 'molecule_i_1', '9n8c4pgu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__bcc14b', 'molecule_i_1', '4h');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__e954f2', 'molecule_i_1', 'dlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__ef22fa', 'molecule_i_1', 'nprmdposii');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__7cc148', 'molecule_i_1', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'molecule_i_1', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('C', 'molecule_i_1', 'a2ypuzhsrwbb');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 'molecule_i_1', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('G', 'molecule_i_1', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t2__2c19e8', 'molecule_i_1', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('D', 'molecule_i_1', 't1__6505dc');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'molecule_i_1', NULL);

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__5c8234', 't2__bcc14b', 't1__7cc148');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__e954f2', 't2__ef22fa', 't2__2c19e8');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__bcc14b', 't2__bcc14b', 'D');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('t2__ef22fa', 't2__e954f2', '@');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_id, T2.atom_id, T2.atom_id2 FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.bond_type = '-';

/*
Gold Result:
('t1__7cc148', 't2__5c8234', 't2__bcc14b')
('t2__2c19e8', 't2__e954f2', 't2__ef22fa')
*/

-- Prediction Query
SELECT T1.bond_type, T2.atom_id, T2.atom_id2 FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.bond_type = '-';

/*
Prediction Result:
('-', 't2__5c8234', 't2__bcc14b')
('-', 't2__e954f2', 't2__ef22fa')
*/
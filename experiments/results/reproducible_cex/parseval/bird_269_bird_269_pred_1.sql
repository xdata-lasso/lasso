-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__dd329e', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 'A', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 'A', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'G', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'A', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'Q', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'A', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'O', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'A', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__dd329e', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__dd329e', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't3__811f89', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't3__811f89', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_14', 't3__811f89', 'i');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't3__811f89', 'i');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__dd329e', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('_', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', 'hria2ypuzhs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'rwbbp6luhvd');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', 'tti');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', 'bnp');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t3__811f89', 'mdpos');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__ad2740', 'zbuo4nrqrof');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t3__f27541', 't1__dd329e', '9n8');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 't3__811f89', 'ie5');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 't3__811f89', 'nw6klf');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 't3__811f89', 'a9000t5c4eci');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 't3__811f89', 'gce376nium52');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.bond_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T1.element = 'i';

/*
Gold Result:
(19,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT c.bond_id) FROM connected AS c JOIN atom AS a ON c.atom_id = a.atom_id WHERE a.element = 'i';

/*
Prediction Result:
(0,)
*/
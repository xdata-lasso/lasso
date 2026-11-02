-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 'ato_e18fa8', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR000_2', 'ato_e18fa8', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 'ato_e18fa8', 'gu7v');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 'ato_34542e', 'ia2yp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 'ato_34542e', 'uzhsrwbbp6lu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 'ato_34542e', 'hvdlttilbnpr');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 'ato_34542e', 'dpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 'ato_34542e', 'ie5');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 'ato_34542e', 'nw6klf');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_10', 'ato_34542e', 'a9000t5c4eci');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_11', 'ato_34542e', 'gce376nium52');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ato_e18fa8', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ato_34542e', '4h');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.molecule_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T2.atom_id = 'TR000_2' AND T2.atom_id2 = 'TR000_4';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT molecule_id FROM atom WHERE atom_id IN ('TR000_2', 'TR000_4');

/*
Prediction Result:
('ato_e18fa8',)
*/
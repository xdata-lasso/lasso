-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O!^c#5', 'molecule_i_1', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR009_12', 'molecule_i_1', 'pgu7vfe4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_520683', 'molecule_i_1', 'hsrwbbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_f130d5', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('G!??IU', 'molecule_i_1', 'n');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('bond_id_1', 'molecule_i_1', 'ia2yp');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('O!^c#5', 'TR009_12', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_520683', 'con_f130d5', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('G!??IU', 'TR009_12', 'bond_id_1');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR009_12', 'con_520683', 'bond_id_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.bond_id) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.molecule_id = 'TR009' AND T2.atom_id = T1.molecule_id || '_1' AND T2.atom_id2 = T1.molecule_id || '_2';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM connected WHERE atom_id = 'TR009_12' OR atom_id2 = 'TR009_12';

/*
Prediction Result:
(3,)
*/
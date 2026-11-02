-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_7df94e', 'molecule_i_1', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_f5d365', 'molecule_i_1', 'pgu7vfe4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR000_2', 'molecule_i_1', 'hsrwbbp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_f26200', 'molecule_i_1', 'hvdltt');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_37d484', 'molecule_i_1', 'n');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_29e62c', 'molecule_i_1', 'mdpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('con_26b931', 'molecule_i_1', '5u');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_1', '5k5swwqcgs');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('con_503dd2', 'molecule_i_1', 'ia2yp');

-- Inserting into table: connected --
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_7df94e', 'con_f5d365', 'con_503dd2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR000_2', 'con_f26200', 'con_503dd2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('con_37d484', 'con_29e62c', 'con_503dd2');

INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR000_2', 'con_26b931', 'con_503dd2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_id FROM connected AS T WHERE T.atom_id2 = 'TR000_2';

/*
Gold Result:
*/

-- Prediction Query
SELECT bond_id FROM connected WHERE atom_id2 = (SELECT atom_id2 FROM connected WHERE atom_id = 'TR000_2');

/*
Prediction Result:
('con_503dd2',)
*/
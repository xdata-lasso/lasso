-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('ato_f00547', 't1__27fe33', '5sw');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__44b4f0', 't1__27fe33', 'qcgsk9');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__16ea02', 't1__27fe33', '8c4p');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__e33c06', 't1__27fe33', 'u7');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__4b671e', 't1__27fe33', 'fe4hri');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__23fe5b', 't1__27fe33', 'a2ypuzhsrwbb');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('t2__de4f42', 't1__27fe33', 'p6luhvdlttil');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('ato_9efe41', 't1__27fe33', 'rmdp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 't2__5fb08d', '37');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't2__5fb08d', 'nium52zbu');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't2__5fb08d', 'nrqrofqy');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't2__5fb08d', 's5bbp02e');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__27fe33', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_2', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', 'siie5unw6k');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', 'a9');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', '00t5c4ecigc');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__5fb08d', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.molecule_id FROM (SELECT T1.molecule_id, COUNT(T2.atom_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '-' GROUP BY T1.molecule_id HAVING COUNT(T2.atom_id) > 5) AS t;

/*
Gold Result:
('t1__27fe33',)
*/

-- Prediction Query
SELECT T1.molecule_id, T1.label FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id GROUP BY T1.molecule_id, T1.label HAVING COUNT(T2.atom_id) > 5 AND T1.label = '-';

/*
Prediction Result:
('t1__27fe33', '-')
*/
-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_1', 't1__ffbe4a', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_2', 't1__a57721', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_3', 't1__ea85af', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_4', 't1__3b30cd', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_5', 't1__ffbe4a', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_6', 't1__a57721', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_7', 't1__ea85af', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_8', 't1__3b30cd', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't1__ffbe4a', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('C', 't1__ffbe4a', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_9', 't1__ea85af', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_12', 't1__3b30cd', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 't1__ffbe4a', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_13', 't1__ea85af', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_15', 't1__3b30cd', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't1__ffbe4a', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_16', 't1__ea85af', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_18', 't1__3b30cd', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_19', 't1__ffbe4a', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_20', 't1__a57721', 'O');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_21', 't1__ea85af', 'A');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_22', 't1__3b30cd', 't1__eee1c2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_23', 't1__ffbe4a', 'E');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_24', 't1__a57721', 'E');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_25', 't1__ea85af', '!');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_26', 't1__3b30cd', 't1__eee1c2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_27', 't1__ffbe4a', 'G');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_28', 't1__a57721', 'G');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_29', 't1__ea85af', '!');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_30', 't1__3b30cd', 't1__eee1c2');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_31', 't1__ffbe4a', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_32', 't1__a57721', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_33', 't1__ea85af', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_34', 't1__3b30cd', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_35', 't1__a57721', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_36', 't1__ffbe4a', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_37', 't1__ffbe4a', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_38', 't1__a57721', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_39', 't1__ea85af', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_40', 't1__3b30cd', NULL);

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_41', 't1__ffbe4a', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_42', 't1__a57721', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_43', 't1__ea85af', 't1__8c0716');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('atom_id_44', 't1__3b30cd', 't1__8c0716');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__ffbe4a', '-');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__a57721', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__ea85af', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__3b30cd', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('molecule_i_5', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.element FROM (SELECT T1.element, COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '-' GROUP BY T1.element ORDER BY COUNT(DISTINCT T1.molecule_id) ASC, T1.element NULLS LAST LIMIT 4) AS t;

/*
Gold Result:
('E',)
('G',)
('O',)
('t1__8c0716',)
*/

-- Prediction Query
SELECT a.element FROM molecule AS m INNER JOIN atom AS a ON m.molecule_id = a.molecule_id WHERE m.label = '-' GROUP BY a.element ORDER BY COUNT(a.element) ASC, a.element NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/
-- Schema DDL
CREATE TABLE "a" ("x" INTEGER, "ya" INTEGER, "yx" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: a --
INSERT INTO "a" ("x", "ya", "yx") VALUES (1, -55602865, 'a_y_9c4d78');

INSERT INTO "a" ("x", "ya", "yx") VALUES (1, -59984348, 'HELLO');

INSERT INTO "a" ("x", "ya", "yx") VALUES (1, -664303813, 'a_y_9c4d78');

INSERT INTO "a" ("x", "ya", "yx") VALUES (1, -1022641847, 'a_y_9c4d78');

INSERT INTO "a" ("x", "ya", "yx") VALUES (1, -1726781632, 'HELLO');

INSERT INTO "a" ("x", "ya", "yx") VALUES (1, 247012447, 'HELLO');

INSERT INTO "a" ("x", "ya", "yx") VALUES (1, -1980249628, 'a_y_9c4d78');

INSERT INTO "a" ("x", "ya", "yx") VALUES (1, -734455130, 'x_s_26e1a3');

INSERT INTO "a" ("x", "ya", "yx") VALUES (NULL, 1744686505, 'a_y_9c4d78');

INSERT INTO "a" ("x", "ya", "yx") VALUES (NULL, -1633151678, 'HELLO');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.X AS AX FROM A AS X WHERE X.YX = 'HELLO';

/*
Gold Result:
(1,)
(1,)
(1,)
(None,)
*/

-- Prediction Query
SELECT X.X AS AX FROM A AS X WHERE X.YX = 'HELLO HI';

/*
Prediction Result:
*/
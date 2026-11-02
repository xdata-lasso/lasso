-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: person --
INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_1', -55602865, 'swwqcgsk', 'per_588642', 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_2', 1610062532, 'pgu7vfe4', 'per_588642', 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_3', 1160656988, 'ia2yp', 'per_588642', 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_4', -1670923962, 'rwbbp6luhvd', 'per_588642', 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_5', -1377057208, 'ilbnp', 'per_588642', 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_6', 1236688122, 'dpos', 'per_588642', 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_7', -1576219117, '5u', NULL, 'w6kl');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_8', NULL, 'a9', NULL, 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_9', NULL, '00t5c4e', NULL, 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_10', NULL, 'cigce376nium', NULL, 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_11', 283598170, 'zbuo4nrq', 'rofqyp5s5b', NULL);

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_12', NULL, 'p', 'per_588642', NULL);

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_13', NULL, '02eutliqa11r', 'per_588642', NULL);

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_14', NULL, 'ytoo3o9', 'per_588642', NULL);

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_15', NULL, 'l7', 'per_588642', 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_16', NULL, 'klex14ji', 'per_588642', 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_17', NULL, '7zwau2dwyr', 'per_588642', 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_18', NULL, '13pyu', 'per_588642', 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_19', NULL, '8d99rljsl', 'per_588642', 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_20', NULL, 'b4yp5qi', 'per_588642', 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_21', NULL, 'rkf9vqx5', 'per_588642', 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_22', NULL, 'pz0f8jegd', 'per_588642', 'per_37fcc5');

INSERT INTO "person" ("name", "age", "city", "gender", "job") VALUES ('name_23', NULL, '1vy9uxj4', 'per_588642', 'per_37fcc5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_age_, job FROM (SELECT gender, job, AVG(age) AS meanage FROM person GROUP BY gender, job) ORDER BY avg_age_, job NULLS LAST;

/*
Gold Result:
(None, 'per_37fcc5')
(None, None)
(-1576219117.0, 'w6kl')
(150637267.83333334, 'per_37fcc5')
(283598170.0, None)
*/

-- Prediction Query
SELECT AVG(age), job FROM Person GROUP BY job;

/*
Prediction Result:
(283598170.0, None)
(150637267.83333334, 'per_37fcc5')
(-1576219117.0, 'w6kl')
*/
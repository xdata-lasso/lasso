-- Schema DDL
CREATE TABLE "i055" ("ID" INTEGER, "User" TEXT, "Activity" TEXT, "PageURL" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: i055 --
INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (-55602865, 'i05_06b7c7', 'i05_27dfce', 'swwqcgsk');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (1610062532, 'i05_06b7c7', 'i05_27dfce', 'pgu7vfe4');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (1160656988, 'i05_06b7c7', 'i05_27dfce', 'ia2yp');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (-1670923962, 'i05_06b7c7', 'i05_27dfce', 'rwbbp6luhvd');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (-1377057208, 'i05_06b7c7', 'i05_27dfce', 'ilbnp');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (1236688122, 'i05_06b7c7', 'i05_27dfce', 'dpos');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (-1576219117, '5u', NULL, 'w6kl');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (1620389964, 'i05_06b7c7', NULL, '00t5c4ecigc');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (528680845, 'i05_06b7c7', NULL, '76nium52');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (-443340271, 'i05_06b7c7', NULL, 'uo4nrqrofqy');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (-1106983592, NULL, '5bbp0', '2eutliqa11r');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (2137741668, NULL, 'i05_27dfce', 'ytoo3o9hl7');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (1178636309, NULL, 'i05_27dfce', 'ex1');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (-74849714, NULL, 'i05_27dfce', '7zw');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (481163439, 'i05_06b7c7', 'i05_27dfce', '2dwyrq');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (-1097120355, 'i05_06b7c7', 'i05_27dfce', '78d99r');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (-1362461264, 'i05_06b7c7', 'i05_27dfce', 'l0b4y');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (-1116181514, 'i05_06b7c7', 'i05_27dfce', 'i2rkf');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (222415430, 'i05_06b7c7', 'i05_27dfce', 'x58pz');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (-1529584866, 'i05_06b7c7', 'i05_27dfce', 'd2');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (1675430660, 'i05_06b7c7', 'i05_27dfce', 'y9uxj4');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (-1612443122, 'i05_06b7c7', 'i05_27dfce', 'd');

INSERT INTO "i055" ("id", "user", "activity", "pageurl") VALUES (-736979194, 'i05_06b7c7', 'i05_27dfce', 'h2gn');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "user", "activity", "concatpageurl" FROM (SELECT "activity", "user", GROUP_CONCAT("pageurl", ' ') AS concatpageurl FROM i055 GROUP BY activity, USER) ORDER BY USER, "user" NULLS LAST, "activity" NULLS LAST, "concatpageurl" NULLS LAST;

/*
Gold Result:
(None, '5bbp0', '2eutliqa11r')
(None, 'i05_27dfce', 'ytoo3o9hl7 ex1 7zw')
('5u', None, 'w6kl')
('i05_06b7c7', 'i05_27dfce', 'swwqcgsk pgu7vfe4 ia2yp rwbbp6luhvd ilbnp dpos 2dwyrq 78d99r l0b4y i2rkf x58pz d2 y9uxj4 d h2gn')
('i05_06b7c7', None, '00t5c4ecigc 76nium52 uo4nrqrofqy')
*/

-- Prediction Query
SELECT User, Activity, PageURL FROM i055 GROUP BY User, Activity;

/*
Prediction Result:
(None, '5bbp0', '2eutliqa11r')
(None, 'i05_27dfce', 'ytoo3o9hl7')
('5u', None, 'w6kl')
('i05_06b7c7', None, '00t5c4ecigc')
('i05_06b7c7', 'i05_27dfce', 'swwqcgsk')
*/
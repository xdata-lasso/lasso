-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'Harlan', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 1019800248, '2022-11-06 10:19:41+00:00', 'Harlan', '2020-06-20 11:35:06+00:00', 'tti', 'bnp', 'mdpos', -1576219117, -1823627488, -1209887326, -1399556171, 1038707349, '9000t5c4ec');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483646, -1683203397, '2025-04-19 21:11:20+00:00', 'Harlan', '2020-08-15 08:54:31+00:00', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, -868774469, -1068298341, -314162272, 'ytoo3o9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483645, -1666765085, '2025-11-19 11:50:18+00:00', 'Harlan', '2024-06-06 15:16:07+00:00', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444, -977635379, 1661181156, -1372125820, -2031361952, 'p5qi2rk');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483644, -705985602, '2025-02-21 13:28:29+00:00', 'Harlan', '2025-05-10 04:07:07+00:00', '58pz0f', '8jegd21vy9ux', 'j4hwbdvlph', -261132974, -1264842910, -1052964641, -1245682094, -1660358170, 'p');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483643, -988981234, '2022-08-03 01:56:16+00:00', 'Harlan', '2022-09-06 20:15:01+00:00', 'dz79fjg', '8n2f3', 'dqv0gcb98ozk', -155284187, 1686459626, -1554531873, 982314585, 638024588, '6vck6ah0f8js');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1, '2022-12-13 04:17:12+00:00', 'lq7xb7', '2025-04-29 15:45:27+00:00', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 1129658414, 1250290042, -1717646459, -1696173285, 710458518, 'sj3ayxp1q430');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1, '2023-08-17 20:15:35+00:00', 'Harlan', '2024-11-10 21:13:22+00:00', 'jh3den8c68', '8vacx7', 'f', -47052816, 645287482, 765724008, -1099855564, 87529806, 'ctdctmfg62g0');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483640, 1870300798, '2024-03-11 08:01:44+00:00', 'Harlan', '2025-11-17 07:39:50+00:00', '8qdjp', '1i', '2278', 2004147439, -691774480, -1523347137, 1582582341, 453836040, '6b');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1, '2021-11-07 01:38:36+00:00', 'u5zi', '2023-12-14 20:00:33+00:00', 'c4bfkfoac', '0', '7z2zezjo7wg', 1248858185, -57705450, -915385605, -2005628382, 1721638020, '0oztdgj5i3lq');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2025-11-16 21:50:04+00:00', 'Harlan', '2024-03-22 11:27:27+00:00', 'npi', '5k58', 's27p2', 1497321728, -95808609, -244633520, 418247369, -1524425594, 'a3o');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483637, -1428186898, '2024-08-16 16:07:41+00:00', 'Harlan', '2025-10-29 05:35:50+00:00', 'uttmu2ne578l', 'vy', '7zzbe8y', -705922211, 1043710187, 318331233, -233617564, 79330142, '58b4pm');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1, '2020-01-08 04:07:26+00:00', 'us3auvmkrpdj', '2025-10-04 15:32:15+00:00', 'zw5chn', 'mo705a9n0', 'xfo', -1793230843, -441521858, 2015094998, 1010672881, -1197954156, '0');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1, '2022-03-19 07:41:34+00:00', 'Harlan', '2025-04-29 20:31:18+00:00', '0k32odwcl5a', 'msorlwyngc', 'dj9erhi', 1056589776, -499913447, -360096930, -1942581013, -795975227, 'xuzkb52');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483634, -277407746, '2022-12-04 16:04:40+00:00', 'Harlan', '2021-10-10 22:42:32+00:00', 'as6', 'elboeowii1', '5nxih66', -251205568, 287256667, 1614799674, 1083479253, 1774679448, 'oaawg96aq');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1, '2020-03-03 02:26:18+00:00', 'tbindz3', '2024-09-22 10:31:45+00:00', 'ajz9t', '8', '5wcg', -794767771, 989306270, 1147652228, 1378873397, 1964331395, 'bd0w9603v');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 1, '2023-05-02 20:56:40+00:00', 'Harlan', '2025-10-31 13:59:15+00:00', 'xw1rxe9yfk7', 'k162n', '55', 2105860871, -141591627, 440797047, -732999244, 1654100852, 'dza35rmki');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483631, -1160642134, '2024-07-20 09:13:00+00:00', 'Harlan', '2022-05-12 04:24:33+00:00', 'i2hy08ftp6', 'wt', 'xxnja', -2080232972, 462225708, 1528227252, -1277305894, -1659775598, 'p6sto1cj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, 1, '2024-08-04 01:35:33+00:00', 'h5knz', '2025-06-29 15:21:32+00:00', 's7dyyd1', 'jmgjach8qt', 'a8y3a17v4yg', -2081662466, -1941472821, -2082238979, -845136979, -1042976410, 'm5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, 1, '2025-01-14 14:36:19+00:00', 'Harlan', '2024-12-17 16:33:36+00:00', 'wlic7dn2np4', '0xdmsqtge', 'cuq', -1750715330, 277649518, 908468929, 1149620614, -1414362698, '1quik');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483628, 1570917601, '2025-10-15 06:35:43+00:00', 'Harlan', '2020-12-11 03:49:02+00:00', '0', 'hlst1pqom', 'ztv', -1304516770, -1558272216, 195316816, 1728201214, -1370566258, '8');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (14, 1, '2020-09-11 22:26:51+00:00', 'tb8r9114qbre', '2025-08-27 08:26:07+00:00', 'bjeuuwsj8', 'jh8', 'wpxlvris', 2042428747, 1228655416, -388527046, -1040951738, -1218774640, 'gc8s3b7v88k');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (15, 1, '2023-01-07 20:03:41+00:00', 'Harlan', '2020-05-31 07:24:38+00:00', 'dbdh', '6j47n', 'ar50hs', -1515201134, -2121944911, 1195320303, 1463445550, -1096060187, 'mwfw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483625, -544173163, '2022-05-10 05:10:46+00:00', 'Harlan', '2021-06-25 02:35:55+00:00', 'w', '014', '5dqts', -1340460158, -2098439423, -459764012, -1148194959, 944310519, '6dd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DisplayName FROM users WHERE DisplayName IN ('Harlan', 'Jarrod Dixon') AND Reputation = (SELECT MAX(Reputation) FROM users WHERE DisplayName IN ('Harlan', 'Jarrod Dixon'));

/*
Gold Result:
('Harlan',)
*/

-- Prediction Query
SELECT CASE WHEN (SELECT MAX(Reputation) FROM users WHERE DisplayName = 'Harlan') > (SELECT MAX(Reputation) FROM users WHERE DisplayName = 'Jarrod Dixon') THEN 'Harlan' ELSE 'Jarrod Dixon' END AS UserWithHigherReputation;

/*
Prediction Result:
('Jarrod Dixon',)
*/
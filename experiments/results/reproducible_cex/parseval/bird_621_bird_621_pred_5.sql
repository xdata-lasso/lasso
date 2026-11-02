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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 1072996612, '2024-04-12 00:38:47+00:00', 'uhv', '2020-06-20 11:35:06+00:00', 'tti', 'bnp', 'mdpos', -1576219117, -1823627488, -1209887326, -1399556171, 1038707349, '9000t5c4ec');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -1683203397, '2025-04-19 21:11:20+00:00', '37', '2024-04-11 14:30:53+00:00', 'ium5', 'zbuo4nrq', 'rofqyp5s5b', 2107872094, 882961052, 743312762, -1822992503, -868774469, 'qa1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1, '2023-03-18 23:06:49+00:00', 'oo3o9', '2020-12-13 17:48:30+00:00', '72k', 'ex1', 'ji7zwau2', 364869063, -953437896, -1097120355, 244829661, -1362461264, 'l0b4y');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1, '2025-02-03 05:21:58+00:00', '5qi2', '2022-04-27 23:55:02+00:00', 'f9v', 'x58pz', 'f8jegd2', 1675430660, -688509700, -792092619, -1492524358, -1612443122, 'd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1, '2022-03-02 18:03:57+00:00', 'nqcx5h', '2021-10-14 14:41:11+00:00', 'p', 'jtu0d', '79fjgq8', -1255130038, -1762857309, 806170397, 513454646, -688216274, 'gcb98ozk3z');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2020-02-20 05:24:11+00:00', 'lyr', '2021-06-12 16:42:05+00:00', 'n6vck6ah0f', 'jswwlq7xb', '72fxa7ryfd', 564390026, -1259474148, 2011234363, -1483100200, -7597509, 'h5ogrgjd8yz');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1, '2022-05-19 02:17:07+00:00', 'tsj', '2023-11-11 06:21:01+00:00', 'y', 'p1q430', 'jh3den8', 195720193, 1774087382, 1732258051, -1762140823, 1371234901, '1of77p');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1, '2023-05-23 12:32:01+00:00', '72ct', '2020-06-07 10:59:23+00:00', 't', 'mfg62g0v5q8q', 'j', -1139855872, -288338724, 1897687032, -241848752, 2004147439, 'tjpttg');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1, '2024-02-13 05:21:59+00:00', 'f', '2021-05-31 16:00:51+00:00', 'oa', 'cd07z2zezjo7', 'wgxd5ysxcm', 1721638020, 983324983, 1269522000, 853709925, -870767087, 'j5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 1, '2021-01-24 01:19:46+00:00', 'lq5lnpim', '2024-02-22 11:40:18+00:00', '58q', 's27p2r94gth2', 'najj', -1351793914, 1919033056, -1428186898, -761353513, 362376128, 'mu2ne578lf');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, 1, '2024-08-15 05:55:27+00:00', 'yvkv42q7sx58', '2025-10-20 14:58:18+00:00', '4', 'pmaus3auvmkr', 'pdjwzw5chn9', 101754718, 628082526, -1245584612, 1731843275, -582376271, 'fwsz');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, 1, '2020-06-20 19:03:43+00:00', '2zob', '2020-04-02 11:13:10+00:00', 'q0k32od', 'cl5ams', 'orlwyngc1dj', 211603887, -413043724, 761519897, 1504707292, 955267863, 'eyo6');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (14, 1, '2022-10-03 01:08:43+00:00', 'kb521gw', '2021-10-10 22:42:32+00:00', 'as6', 'elboeowii1', '5nxih66', -251205568, 287256667, 1614799674, 1083479253, 1774679448, 'oaawg96aq');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (15, 1, '2020-03-03 02:26:18+00:00', 'tbindz3', '2024-09-22 10:31:45+00:00', 'ajz9t', '8', '5wcg', -794767771, 989306270, 1147652228, 1378873397, 1964331395, 'bd0w9603v');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (16, 1, '2020-09-21 12:30:27+00:00', '7qk', '2024-12-06 05:16:35+00:00', '162nh55y3d', 'ohvu06dza3', 'rmkio18r', 431832073, 1510892261, 1677948887, 389700824, -1853955201, 'qxxnj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (17, 1, '2020-01-09 12:53:38+00:00', 'bymzn2mfx7h3', '2023-11-11 00:49:07+00:00', '6sto', 'cj8sh5k', 'zys7', 1487347213, 1328948152, -1923069176, -1520090613, 591870819, 'jach8qta8y3');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (18, 1, '2024-12-03 19:29:06+00:00', '4ygmay', '2022-03-25 00:11:27+00:00', 'qdpuap96', 'ntdqr', 'm5', -648564084, -1573704891, -1260548409, 1409697108, -1104749933, '0xdmsqtge');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (19, 1, '2021-06-30 19:59:42+00:00', 'u', '2025-02-01 17:53:54+00:00', 'b9i9f', 'ccukjq1q', 'ik1yhb', 1862728578, 1909521477, 2101986789, 1980131681, 1222311103, 'ztv');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (20, 1, '2024-02-08 09:58:00+00:00', 'z78', '2020-01-14 09:22:01+00:00', 'qlud8', 'tb', 'r9114qbre', 316163741, -752650834, 2134937984, 1379644459, 136003842, 'h85');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (21, 1, '2023-01-17 07:11:46+00:00', 'xlvr', '2021-02-03 14:27:41+00:00', 'surz0kaqtncg', 'c8s3b7v88k', 'dmdbdh', 313797011, 1946419004, -1215810104, -982188592, 1981548099, 'sj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (22, 1, '2023-02-27 07:54:12+00:00', 'p', '2022-10-01 02:03:07+00:00', 'mwfw', 'qrlawk', '14r5dqt', 1298113538, -1340460158, -2098439423, -459764012, -1148194959, 'pj6ddly');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (23, 1, '2022-06-01 09:30:47+00:00', 'u6iphdku2gi', '2022-04-07 11:26:08+00:00', '31vwq51oa2sb', 'uoi1pavc', 'wnyqro', 917675957, -1582954378, -1143329124, 1368469085, 3208964, 'xyfvmjwpp26');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 1, 't2__345c6a', '2020-04-05 14:43:51+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 1, 't2__345c6a', '2020-03-08 22:40:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483646, 4, 't2__345c6a', '2023-08-19 04:29:46+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483645, 4, 't2__345c6a', '2022-05-03 02:13:10+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 4, 't2__345c6a', '2023-03-22 03:47:49+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483643, 1, 't2__345c6a', '2024-10-18 05:00:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (4, 2, 'lph2gn', '2020-07-01 12:41:54+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (5, 6, '1afgo', '2020-11-22 11:14:57+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (6, 8, 'bnou5zi36', '2020-04-09 11:24:06+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (7, 10, 'yz7zzb', '2020-08-06 07:31:44+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (8, 12, 'l0hdt6fuqyx', '2025-10-17 20:09:18+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (9, 14, 'xw1rxe9', '2023-04-03 03:00:30+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (10, 16, '1', '2024-06-15 08:55:45+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (11, 18, '6', '2021-09-01 18:50:29+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (12, 20, 'an', '2023-05-02 01:41:48+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (13, 22, 'b3aj', '2023-07-13 19:13:57+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Name FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T1.Reputation = (SELECT MIN(Reputation) FROM users);

/*
Gold Result:
('t2__345c6a',)
('t2__345c6a',)
('t2__345c6a',)
*/

-- Prediction Query
SELECT DISTINCT "badges"."name" FROM "badges" INNER JOIN "users" ON "badges"."userid" = "users"."id" WHERE "users"."reputation" = (SELECT MIN("reputation") FROM "users");

/*
Prediction Result:
('t2__345c6a',)
*/
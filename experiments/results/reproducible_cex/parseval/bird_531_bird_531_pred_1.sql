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

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483642, -658391922, '2021-07-03 08:58:16+00:00', 'Harlan', '2022-03-20 09:18:33+00:00', 'xb72fxa7r', 'fdrz16n', 'jja', -7597509, -1625552518, -1738458256, -1714354341, -458359144, '1afgogritsj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1, '2023-11-11 06:21:01+00:00', 'Harlan', '2020-02-17 22:42:09+00:00', 'xp1q430', 'jh3den8', 'c68x8vacx7', 1523825314, 2078438287, -47052816, 645287482, 765724008, '7pzo72ctd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1, '2020-04-27 21:49:53+00:00', 'mfg62', '2020-10-18 11:14:36+00:00', 'v5q8qdj', 'e1io', '278507cv', -866772222, -847293924, -2033879835, 1798111945, 944975670, 'i36c4bf');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483639, -1173368267, '2025-01-04 09:05:19+00:00', 'Harlan', '2020-05-22 14:53:50+00:00', '0', '7z2zezjo7wg', 'd5ysxc', -405743609, -1935752926, -20116244, -176606723, -15162884, 'pim5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2021-06-04 00:33:11+00:00', 'Harlan', '2024-03-11 05:11:39+00:00', 'qs27p2r94', 'th', '2mnajjla3o', -1428186898, -761353513, 362376128, -1311735207, -229022515, '57');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1, '2024-07-14 22:10:32+00:00', 'fvy', '2023-05-05 20:15:58+00:00', 'zzbe8yvkv', '42q7sx58b4', 'pmaus3auvmkr', 609771851, -1934017803, 1105964624, -663234145, -2013213247, '9mo7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483636, -354292049, '2025-06-30 18:54:45+00:00', 'Harlan', '2020-01-14 04:43:10+00:00', '9n0jxfofwsz', 'o', '2zobb0q0k32o', -1898678660, 440115543, 292557306, 709097796, -984562992, 'yngc1d');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1, '2025-02-24 09:11:47+00:00', 'Harlan', '2021-03-29 22:07:48+00:00', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', -30041412, -277407746, -670154354, -2140468103, 469838697, 'lboeowii1z5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1, '2021-10-05 09:01:22+00:00', 'xih662q2xly', '2025-01-25 14:56:35+00:00', 'tow9', 'aawg', '6aqb0tbin', -1897615568, 2085299664, 2038321753, 1376887048, 261633665, '8');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483633, 748154000, '2023-01-06 00:58:47+00:00', 'Harlan', '2020-04-24 22:41:34+00:00', 'um', 'c', '3tdu6bd0w960', 740386991, 2018368241, 920097188, -639616320, 1689143863, 'e9yfk7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 1, '2022-03-07 06:27:54+00:00', 'Harlan', '2021-06-04 20:05:45+00:00', '162nh55y3d', 'ohvu06dza3', 'rmkio18r', 431832073, 1510892261, 1677948887, 389700824, -1853955201, 'qxxnj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1, '2020-01-09 12:53:38+00:00', 'bymzn2mfx7h3', '2023-11-11 00:49:07+00:00', '6sto', 'cj8sh5k', 'zys7', 1487347213, 1328948152, -1923069176, -1520090613, 591870819, 'jach8qta8y3');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483630, -2125172723, '2024-06-15 08:55:45+00:00', 'Harlan', '2024-12-03 19:29:06+00:00', '4ygmay', '3qdpu', 'p', -845136979, -1042976410, -1670945624, 555368535, -1369148652, '7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, 1, '2025-06-14 15:18:28+00:00', 'Harlan', '2020-07-05 10:00:11+00:00', 'n2np490xdms', 'tgelc', 'qb9i9f', -788896327, -1541581575, -325680600, -796609690, -1459013972, 'yhb08hlst1pq');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, 1, '2021-12-09 20:20:01+00:00', 'iztv', '2020-02-24 04:19:02+00:00', 'm4iz78aqq', 'ud8', 'tb', 192271618, -312228770, 1618264449, 1639204149, -2063751689, '6b');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483627, -1537647691, '2024-12-21 23:01:28+00:00', 'Harlan', '2022-08-29 13:30:01+00:00', 'wsj8kj', '85', 'pxlvri', 986268139, 2042428747, 1228655416, -388527046, -1040951738, 'ncgc8s3b7v');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (15, 1, '2024-07-30 17:06:35+00:00', 'Harlan', '2024-08-11 08:09:06+00:00', 'wdm', 'b', 'h', 313797011, 1946419004, -1215810104, -982188592, 1981548099, 'sj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (14, 1, '2020-12-24 03:00:15+00:00', 'n', '2023-05-02 01:41:48+00:00', 'dpunmw', 'wx', 'rlawk', 558684943, -120625031, 572453185, 1348973408, -911953404, '97');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DisplayName FROM users WHERE DisplayName IN ('Harlan', 'Jarrod Dixon') AND Reputation = (SELECT MAX(Reputation) FROM users WHERE DisplayName IN ('Harlan', 'Jarrod Dixon'));

/*
Gold Result:
('Harlan',)
*/

-- Prediction Query
SELECT DisplayName, MAX(Reputation) FROM users WHERE DisplayName IN ('Harlan', 'Jarrod Dixon') GROUP BY DisplayName ORDER BY Reputation DESC, DisplayName NULLS LAST, MAX(Reputation) NULLS LAST LIMIT 1;

/*
Prediction Result:
('Harlan', 1019800248)
*/
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

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1, '2023-11-11 06:21:01+00:00', 'y', '2023-01-25 15:19:02+00:00', '1q43', '1jh3den', 'c68x8vacx', -1762140823, 1371234901, -290314193, 76996700, -435350511, '72ctdctmfg62');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1, '2020-10-18 11:14:36+00:00', 'Harlan', '2023-07-14 21:32:37+00:00', '5q8qdj', 'e1io', '278507cv', -866772222, -847293924, -2033879835, 1798111945, 944975670, 'i36c4bf');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483639, -1173368267, '2025-01-04 09:05:19+00:00', 'Harlan', '2020-05-22 14:53:50+00:00', '0', '7z2zezjo7wg', 'd5ysxc', -405743609, -1935752926, -20116244, -176606723, -15162884, 'pim5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1, '2021-06-04 00:33:11+00:00', '8qs27p2r', '2024-09-21 04:14:02+00:00', '4gth2mnajjla', 'okv8uttm', '2ne578', 1908593332, 697257217, -451030047, -2052653308, -489120589, 'v42');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2022-03-14 12:32:27+00:00', 'Harlan', '2024-11-20 13:19:41+00:00', 'sx58b4pma', 'us3auvmkrpdj', 'wzw5chn9mo70', 628082526, -1245584612, 1731843275, -582376271, -1165594842, 'szdo2z');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483636, 270415200, '2020-02-24 22:37:14+00:00', 'Harlan', '2020-04-02 11:13:10+00:00', 'q0k32od', 'cl5ams', 'orlwyngc1dj', 211603887, -413043724, 761519897, 1504707292, 955267863, 'eyo6');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1, '2025-09-03 22:53:15+00:00', '0hd', '2022-07-28 02:01:37+00:00', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 1557188093, 548968280, -1552469358, 7342822, -1034034171, 'lyotow');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1, '2024-08-29 05:28:03+00:00', 'Harlan', '2021-12-24 12:13:22+00:00', 'aawg96aqb0tb', 'indz39tajz', 'td8n5wcgu', -1275298282, 1933158443, 1295379066, 1071401016, 40558455, 'vzxw1rxe');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483633, -505019168, '2021-05-30 10:13:06+00:00', 'Harlan', '2024-07-02 05:26:35+00:00', 'k162n', '55', '3dohvu0', 30861410, -438741674, -154207334, 729449685, -1580984044, '8ri2hy0');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1, '2025-01-05 20:14:57+00:00', 'ftp6ewtqx', '2023-01-28 06:02:52+00:00', 'jaby', 'mzn2mfx7h3', 'p6sto1cj', 1728926031, -63214972, 1106724223, 1966809332, 1487347213, 'yd1jmgj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 1, '2020-01-28 22:49:30+00:00', 'Harlan', '2020-04-10 08:01:49+00:00', '8q', 'ta8y3a17v4', 'ygmayq3qdpu', 1595033206, 1291298007, 1982265552, 2013152515, 1139012231, 'hm5wl');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483630, -1573704891, '2024-06-05 19:57:42+00:00', 'Harlan', '2025-06-14 15:18:28+00:00', 'dn2np490xdms', 'tgelc', 'qb9i9f', -788896327, -1541581575, -325680600, -796609690, -1459013972, 'yhb08hlst1pq');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, 1, '2021-12-09 20:20:01+00:00', 'iztv', '2020-02-24 04:19:02+00:00', 'm4iz78aqq', 'ud8', 'tb', 192271618, -312228770, 1618264449, 1639204149, -2063751689, '6b');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, 1, '2024-11-17 03:39:21+00:00', 'Harlan', '2021-03-17 03:25:47+00:00', 'uu', 'sj8kjh', '5wpxlvris', 2042428747, 1228655416, -388527046, -1040951738, -1218774640, 'gc8s3b7v88k');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483627, -622923312, '2021-08-26 17:02:25+00:00', 'Harlan', '2020-07-06 15:58:49+00:00', 'd', 't6', 'j47nxar50h', 460471995, -1515201134, -2121944911, 1195320303, 1463445550, 'p');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (14, 1, '2022-10-01 02:03:07+00:00', 'mwfw', '2023-03-05 19:15:05+00:00', 'rlawk', '14r5dqt', 'mg97a', -1019350771, -225571092, -261782899, -1079009577, -1385967617, 'u6iph');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (15, 1, '2020-05-26 13:36:15+00:00', 'Harlan', '2021-06-07 11:18:19+00:00', 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 1754053934, 1206923461, 1645850786, -471852873, -1005394301, 'uirlrpouit');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DisplayName FROM users WHERE DisplayName IN ('Harlan', 'Jarrod Dixon') AND Reputation = (SELECT MAX(Reputation) FROM users WHERE DisplayName IN ('Harlan', 'Jarrod Dixon'));

/*
Gold Result:
('Harlan',)
*/

-- Prediction Query
SELECT CASE WHEN u1.Reputation > u2.Reputation THEN 'Harlan' ELSE 'Jarrod Dixon' END AS UserWithHigherReputation FROM users AS u1 CROSS JOIN users AS u2 WHERE u1.DisplayName = 'Harlan' AND u2.DisplayName = 'Jarrod Dixon' ORDER BY u1.Reputation DESC, u1.id NULLS LAST, u2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/
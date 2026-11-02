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
-- Inserting into table: posts --
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, -1910425938, -845863578, '2021-01-23 18:11:33+00:00', -1364429300, -1257178728, 'mdpos', 1, '2021-02-17 05:47:13+00:00', 'e5u', 'w6kl', 1620389964, 546571701, 947159877, 1, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', -1964997180, '2025-03-10 20:24:26+00:00', 'ce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 328305758, -751275471, '2021-08-01 11:21:15+00:00', -1068298341, -314162272, 'ytoo3o9', 1, '2020-12-13 17:48:30+00:00', '72k', 'ex1', -74849714, 105869088, -2081315180, 1, '2023-10-12 22:40:24+00:00', '2025-11-10 22:24:59+00:00', 1909986641, '2023-01-13 04:58:30+00:00', 'yrq13pyu78d9', 'rljsl0b4y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1255852738, -1555456236, '2022-04-27 23:55:02+00:00', 2056419640, 222415430, 'x58pz', 1, '2023-06-28 05:47:44+00:00', 'f8jegd21vy9u', 'j4hwbd', -736979194, 2103044118, -1642259219, 1, '2020-12-04 21:49:29+00:00', '2021-09-30 11:37:26+00:00', 1968874827, '2022-12-08 23:34:02+00:00', 'qcx5', 'hncprjtu0dz');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -1609653472, -1405314653, '2025-11-16 21:50:04+00:00', 1816660482, -1212676731, 'm5k', 1, '2024-03-11 05:11:39+00:00', 'qs27p2r94', 'th', 333302050, 1162591638, -2136247961, 3, '2021-04-29 06:47:06+00:00', '2021-07-29 14:03:28+00:00', -2096405521, '2025-01-03 11:54:20+00:00', 'kv8u', 'tmu2n');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, 448935289, 458835042, '2020-08-06 07:31:44+00:00', -489120589, -72442907, '7sx58', 1, '2025-10-20 14:58:18+00:00', '4', 'pmaus3auvmkr', 609771851, -1934017803, 1105964624, 3, '2023-06-01 10:01:12+00:00', '2022-12-09 16:13:13+00:00', -55494714, '2020-12-08 09:40:56+00:00', '9mo7', '5a9n0jx');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, 1010672881, -1197954156, '2020-04-02 11:13:10+00:00', -397848196, -366775518, '2odwcl5a', 1, '2025-04-19 10:34:51+00:00', 'msorlwyngc', 'dj9erhi', 1056589776, -499913447, -360096930, 4, '2020-05-28 05:20:14+00:00', '2022-07-28 02:01:37+00:00', -795975227, '2023-04-23 07:11:55+00:00', 'uzkb52', 'gwnlas6');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483642, -251205568, 287256667, '2023-03-16 20:38:44+00:00', 412199481, 727608179, 'awg96aqb0tbi', 1, '2025-04-01 08:16:25+00:00', 'dz39', 'ajz9t', 748154000, 1148916014, -1988582944, 1, '2022-09-05 12:39:02+00:00', '2021-09-22 22:06:25+00:00', 989306270, '2025-03-26 09:37:26+00:00', 'tdu6bd0w96', '3vzxw1r');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -1910425938, -845863578, '2021-01-23 18:11:33+00:00', -1364429300, -1257178728, 'mdpos', 2, '2021-02-17 05:47:13+00:00', 'e5u', 'w6kl', 1620389964, 546571701, 947159877, 1, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', -1964997180, '2025-03-10 20:24:26+00:00', 'ce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -1438850342, -305670381, '2021-03-25 19:22:18+00:00', 105869088, -2081315180, '2dwyrq13pyu7', 5, '2024-08-08 00:51:45+00:00', '9', 'rljsl0b4y', -1116181514, 1255852738, -1555456236, 2, '2022-04-27 23:55:02+00:00', '2021-05-26 08:15:06+00:00', -705985602, '2025-02-21 13:28:29+00:00', 'x58pz0f8jeg', 'd21vy9uxj4hw');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 1581736075, -261132974, '2021-09-30 11:37:26+00:00', 1968874827, -664193365, 'cx5hn', 6, '2020-05-10 07:36:02+00:00', 'rjtu', 'dz79fjg', -1255130038, -1762857309, 806170397, 6, '2025-08-02 02:30:29+00:00', '2025-05-19 00:55:13+00:00', 513454646, '2022-11-21 14:30:10+00:00', 'gcb98oz', '3zb');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -1659388584, 1526238907, '2021-07-11 07:27:32+00:00', -845863578, -1610064545, 'n', 7, '2022-01-18 15:57:55+00:00', 'mdpos', 'ie5', -1209887326, -1399556171, 1038707349, 6, '2024-12-31 04:19:17+00:00', '2024-10-02 15:57:32+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, -1666765085, 1178636309, '2021-07-01 18:29:24+00:00', -305670381, -1525670226, '7zwau2dwyr', 8, '2022-03-25 08:00:08+00:00', '3pyu78d', '9rljsl0b4', 1649269347, -1116181514, 1255852738, 8, '2021-03-04 06:15:13+00:00', '2023-10-21 02:54:45+00:00', -975213201, '2020-10-15 10:13:01+00:00', 'vqx58pz0f', '8jegd21vy9ux');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, -211209314, -1056308489, '2023-06-17 22:27:46+00:00', 331812443, 1382410067, '9', 9, '2024-08-05 04:49:57+00:00', 'zk3z', 'i', -512640349, 1038566008, 32204797, 2, '2020-04-16 10:31:38+00:00', '2021-05-17 23:21:59+00:00', 37673509, '2025-01-10 14:09:09+00:00', 'h0f8jswwlq7x', '7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 710458518, 678047687, '2021-04-29 04:39:04+00:00', -197933860, 2111987706, 'p1q430', 10, '2023-08-17 20:15:35+00:00', 'jh3den8c68', '8vacx7', 1523825314, 2078438287, -47052816, 5, '2025-07-13 05:36:35+00:00', '2023-09-05 10:31:30+00:00', 765724008, '2024-06-30 03:42:59+00:00', 'pzo72ctdc', 'mfg62');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'Community', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -2078052421, '2021-07-02 01:45:48+00:00', 'Community', '2023-03-28 14:41:46+00:00', 'kn6vc', '6ah', 'f8jswwl', 1255343543, -541746689, 1294666887, -515895469, 1427161052, 'z16ni');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -1483100200, '2021-02-04 08:22:25+00:00', 'dh5ogrgj', '2020-06-19 19:37:13+00:00', 'yzt1afgog', 'itsj3', 'y', -598313376, 1972233925, 1792827279, 804529642, -1538707438, 'den8c68x');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'Community', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -1179823637, '2021-09-24 11:50:48+00:00', 't3__76be74', '2025-01-09 01:18:18+00:00', 'rqrofqyp5s5b', 'p', '02eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, '9hl7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -55602865, '2024-02-19 01:18:26+00:00', 'Community', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -443340271, '2025-10-02 08:51:14+00:00', 'Community', '2022-10-09 12:52:21+00:00', '4nrq', 'rofqyp5s5b', 'p', 882961052, 743312762, -1822992503, -868774469, -1068298341, '1ryytoo');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, -2050247126, '2022-10-17 07:55:28+00:00', 'Community', '2021-07-30 02:29:08+00:00', 'h2gn', 'q', 'nqcx5h', -1245312912, 1575412235, -988981234, -841004020, -361507387, '79fjgq8');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 2094425101, '2020-01-31 17:55:18+00:00', 'Community', '2024-12-20 11:42:02+00:00', 'ryfdrz16n', 'jja', '5dh', 1583472758, 1449284300, -977470238, -1478247928, 1074760385, 't1afgog');

-- Inserting into table: tags --
INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483648, 'zbuo4nrqrof', 373262291, 1, -472966518);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483647, 'r', 1884179925, 1, 902551284);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483646, '9fjgq8n2f', -1056308489, 4, -1454058168);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483645, 'vacx7afu5', -290314193, 1, 76996700);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483644, '72ct', -1928431425, 4, 1303877941);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483643, 'mfg62g0v5q', 1421303999, 1, -1488156735);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483642, 'io22785', 2119806856, 4, -1962347906);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483641, 'ptt', 1467355421, 1, -1171104889);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483640, 'zi36c4bf', -1173368267, 4, 382831862);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483639, '7z2zezj', 1448731351, 1, -604098478);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (2, '5', -526612570, 1, -546516406);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (3, 'r0oz', -870767087, 1, -1699185893);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483636, '57', -1402164108, 1, 2123471885);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483635, 'of', -634585028, 1, 1719800120);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483634, 'elboeowii1', -457369423, 1, 1557188093);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483633, 'e9yfk7', -1046720861, 1, 643589729);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483632, '55', 2105860871, 1, -141591627);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483631, 'hvu0', 30861410, 1, -438741674);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483630, 't2__4744ac', 1595632888, 1, 2072023304);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (4, 'r', -443340271, 3, 757448742);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (5, 'd', -736979194, 5, 2103044118);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (6, 'lyr', 1038566008, 6, 32204797);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (7, 'r', -1585009206, 7, -53231346);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (8, 'r', -1492524358, 8, -1612443122);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (9, 'r', 602161869, 9, 1350414441);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (10, 'r', -1744557630, 10, 1870300798);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T3.TagName = 'r', 1, 0)) AS REAL) * 100 / COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN tags AS T3 ON T3.ExcerptPostId = T2.PostId WHERE T1.DisplayName = 'Community';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.TagName = 'r' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.Id) FROM posts AS T1 INNER JOIN tags AS T2 ON T1.Id = T2.ExcerptPostId INNER JOIN users AS T3 ON T1.OwnerUserId = T3.Id WHERE T3.DisplayName = 'Community';

/*
Prediction Result:
(25.0,)
*/
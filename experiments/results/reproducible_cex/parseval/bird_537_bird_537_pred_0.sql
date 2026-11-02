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

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -1937207087, 1675430660, '2022-11-21 09:24:31+00:00', 233994589, 1442655647, 'hwbdvlph', 1, '2023-09-26 13:08:37+00:00', 'nd', 'wnqcx', 722884590, 580968159, -1245312912, 1, '2022-01-23 03:13:33+00:00', '2022-04-18 00:53:20+00:00', -1509264256, '2022-09-06 20:15:01+00:00', 'dz79fjg', '8n2f3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -1056308489, -1454058168, '2023-05-15 04:44:08+00:00', 1686459626, -1554531873, 'yrkn6vck6ah0', 1, '2020-10-15 18:29:15+00:00', 'jswwlq7xb', '72fxa7ryfd', 564390026, -1259474148, 2011234363, 4, '2021-04-25 14:26:05+00:00', '2020-01-23 21:20:16+00:00', -7597509, '2025-07-17 09:46:47+00:00', '5o', 'rg');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, 600440952, 1568069663, '2020-09-12 13:47:57+00:00', -1717646459, -1696173285, 'tsj', 1, '2023-11-11 06:21:01+00:00', 'y', 'p1q430', 1923912467, 518609210, 1948383687, 2, '2020-06-27 17:29:33+00:00', '2020-08-20 06:07:09+00:00', 195720193, '2024-08-13 21:17:54+00:00', 'acx7af', '5w1of7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, -1099855564, 87529806, '2020-05-17 14:21:08+00:00', -820614248, 481546706, 'g6', 1, '2023-10-09 23:10:02+00:00', '0v', 'q8qdjpe1', -1180042408, 199672698, 2119806856, 4, '2025-08-02 16:41:48+00:00', '2024-06-06 16:33:41+00:00', 2004147439, '2022-11-19 00:43:43+00:00', 'jpttg', 'bnou5zi36');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -1910425938, -845863578, '2021-01-23 18:11:33+00:00', -1364429300, -1257178728, 'mdpos', 3, '2021-02-17 05:47:13+00:00', 'e5u', 'w6kl', 1620389964, 546571701, 947159877, 1, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', -1964997180, '2025-03-10 20:24:26+00:00', 'ce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -747753377, 902887186, '2025-10-19 18:29:54+00:00', -967741825, 775304493, 'qyp5s5bbp0', 5, '2025-09-22 03:26:15+00:00', 'eutliqa1', 'ryytoo3', -1666765085, 1178636309, -1390245819, 3, '2023-03-10 01:47:11+00:00', '2023-08-25 07:55:29+00:00', -74849714, '2021-02-17 21:51:43+00:00', '7zwau2dwyr', '13pyu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -1659388584, 1526238907, '2021-07-11 07:27:32+00:00', -845863578, -1610064545, 'n', 6, '2022-01-18 15:57:55+00:00', 'mdpos', 'ie5', -1209887326, -1399556171, 1038707349, 6, '2024-12-31 04:19:17+00:00', '2024-10-02 15:57:32+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -1666765085, 1178636309, '2021-07-01 18:29:24+00:00', -305670381, -1525670226, '7zwau2dwyr', 7, '2022-03-25 08:00:08+00:00', '3pyu78d', '9rljsl0b4', 1649269347, -1116181514, 1255852738, 3, '2021-03-04 06:15:13+00:00', '2023-10-21 02:54:45+00:00', -975213201, '2020-10-15 10:13:01+00:00', 'vqx58pz0f', '8jegd21vy9ux');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, -792947627, -1898531797, '2024-06-08 14:05:00+00:00', 401805964, -1485777725, '8n2f3', 8, '2025-11-06 14:42:57+00:00', 'q', '0gcb98', -1454058168, -2078052421, -512640349, 5, '2021-06-12 16:42:05+00:00', '2025-03-26 10:17:14+00:00', 638024588, '2025-11-22 09:05:23+00:00', 'vck6ah0f8', 'sww');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 710458518, 678047687, '2021-04-29 04:39:04+00:00', -197933860, 2111987706, 'p1q430', 9, '2023-08-17 20:15:35+00:00', 'jh3den8c68', '8vacx7', 1523825314, 2078438287, -47052816, 5, '2025-07-13 05:36:35+00:00', '2023-09-05 10:31:30+00:00', 765724008, '2024-06-30 03:42:59+00:00', 'pzo72ctdc', 'mfg62');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'csgillespie', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -443340271, '2025-10-02 08:51:14+00:00', 'csgillespie', '2022-10-09 12:52:21+00:00', '4nrq', 'rofqyp5s5b', 'p', 882961052, 743312762, -1822992503, -868774469, -1068298341, '1ryytoo');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -1666765085, '2025-11-19 11:50:18+00:00', '2klex14ji', '2025-02-02 04:37:17+00:00', 'zwau2dwyr', '13pyu', '8d99rljsl', -346339240, 1692174491, -1025564911, -227162283, 2056419640, 'vqx58pz0f');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -55602865, '2024-02-19 01:18:26+00:00', 't2__fde90c', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -55602865, '2024-02-19 01:18:26+00:00', 'csgillespie', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -1585009206, '2021-08-19 01:10:02+00:00', 'csgillespie', '2024-10-24 14:16:53+00:00', '2zbuo4nr', 'qrofqyp5s5b', 'p', 882961052, 743312762, -1822992503, -868774469, -1068298341, '1ryytoo');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -1492524358, '2021-01-22 00:53:52+00:00', 'csgillespie', '2023-01-02 20:56:29+00:00', 'd', 'lph2gn', 'q', -664193365, -1070063173, 555413010, 722884590, 580968159, 'cprj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, -1388029300, '2024-06-08 00:23:27+00:00', 'csgillespie', '2023-02-17 08:54:45+00:00', '7', '2fxa7ryfdrz', '16nijjai5dh', 1583472758, 1449284300, -977470238, -1478247928, 1074760385, 't1afgog');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T2.DisplayName = 'csgillespie';

/*
Gold Result:
(9,)
*/

-- Prediction Query
SELECT COUNT(Id) FROM posts WHERE OwnerUserId = (SELECT Id FROM users WHERE DisplayName = 'csgillespie');

/*
Prediction Result:
(5,)
*/
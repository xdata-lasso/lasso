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

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 537874887, -461695645, '2025-11-28 13:30:18+00:00', -1529584866, 1196308825, 'd21vy9uxj4hw', 2, '2020-03-11 08:08:02+00:00', 'v', 'ph2', 1298861365, 1968874827, -664193365, 2, '2022-02-18 09:12:59+00:00', '2020-04-10 05:04:30+00:00', 555413010, '2025-09-07 08:46:54+00:00', 'hncprjtu', 'dz79fjg');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, 710458518, 678047687, '2021-04-29 04:39:04+00:00', -197933860, 2111987706, 'p1q430', 4, '2023-08-17 20:15:35+00:00', 'jh3den8c68', '8vacx7', 1523825314, 2078438287, 0, 3, '2022-09-01 11:41:59+00:00', '2024-02-28 09:48:47+00:00', -290314193, '2025-10-08 08:31:18+00:00', '77', 'zo72');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -1171104889, -29242208, '2021-02-17 19:49:53+00:00', 1944978593, 1722106924, 'f', 4, '2021-05-31 16:00:51+00:00', 'oa', 'cd07z2zezjo7', 304189298, -542502665, 0, 1, '2024-02-20 16:52:17+00:00', '2023-03-18 12:07:22+00:00', -915385605, '2020-04-12 14:45:54+00:00', 'r0oz', 'dgj5i');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, -15162884, 1339733032, '2022-01-04 01:02:12+00:00', 1692046802, -1300180872, '58q', 4, '2022-06-11 14:45:41+00:00', '7p2r94gt', '2m', 418247369, -1524425594, 0, 2, '2021-07-29 14:03:28+00:00', '2020-02-06 22:46:22+00:00', 1919033056, '2021-06-04 07:47:26+00:00', '8uttmu', 'ne578lfv');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, 238533676, -1514700303, '2020-09-11 00:02:55+00:00', -1165594842, -634585028, 'do2zobb', 4, '2023-06-19 15:36:55+00:00', '0k32o', 'w', 440115543, 292557306, 0, 0, '2025-08-28 09:25:40+00:00', '2021-12-02 07:29:49+00:00', -984562992, '2023-01-20 18:10:08+00:00', 'ngc1dj9', 'rh');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483642, 1056589776, -499913447, '2020-08-13 21:38:24+00:00', 1483450542, 513375398, 'l0hdt6fuq', 4, '2023-04-23 07:11:55+00:00', 'uzkb52', 'gwnlas6', -2076274980, 1731324803, 0, 2, '2021-12-15 23:43:59+00:00', '2022-12-20 18:28:11+00:00', -1589605308, '2023-09-21 01:04:05+00:00', '5nxih66', 'q2xlyoto');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483641, -1048779857, -381485009, '2020-02-29 08:50:35+00:00', -1216952047, -457901285, 'tajz9td8n', 0, '2025-07-30 07:59:24+00:00', '5wcgumbc3td', 'u6bd0w9603', -541917667, -961629819, -1, 4, '2020-07-22 23:26:49+00:00', '2025-09-23 03:38:51+00:00', 237552112, '2020-09-21 12:30:27+00:00', '7qk', '162nh55y3d');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, 462225708, 1528227252, '2021-09-21 11:15:09+00:00', -1810873111, 1243701948, '3p6sto1c', -1, '2021-04-08 11:35:14+00:00', 'sh5knzys7', 'y', -531932574, 357443379, -1, -2147483642, '2021-08-28 17:15:24+00:00', '2025-06-04 14:14:14+00:00', -1502591405, '2020-04-10 08:01:49+00:00', '8q', 'ta8y3a17v4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483639, -2081662466, -1941472821, '2025-06-16 07:53:05+00:00', -2082238979, -845136979, 'rhm5w', -1, '2021-07-17 00:45:37+00:00', 'c7d', 'n2np490xdms', -1027584872, -1685482179, 0, 2, '2021-06-30 19:59:42+00:00', '2020-05-04 22:25:03+00:00', -1025517017, '2024-09-18 21:46:55+00:00', 'i9f2ccukjq1q', 'ik1yhb');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -1437333179, -921145356, '2023-01-16 20:10:41+00:00', -1022641847, -1726781632, '9n8', 5, '2020-04-30 23:22:06+00:00', 'pgu7vfe4', 'hria2ypuzhs', 700293388, 906324270, 1908028688, -1, '2020-03-08 22:40:47+00:00', '2022-01-03 02:42:55+00:00', 13244799, '2022-09-23 20:24:07+00:00', 'hvdlttilbnpr', 'dpos');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 600401919, -1437333179, '2022-06-06 02:35:43+00:00', -664303813, -1022641847, 'sk', 6, '2024-11-14 12:35:58+00:00', 'n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 6, '2023-10-02 15:43:02+00:00', '2023-03-21 21:13:18+00:00', 1115440883, '2023-05-25 17:04:36+00:00', 'sr', 'wbbp6luhvdlt');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2010-01-01 00:00:00+00:00', 't1__1984a3', '2024-02-19 01:18:26+00:00', 'wwqcg', 'k9n8c', 'pgu7vfe4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -443340271, '2010-01-01 00:00:00+00:00', 't1__1984a3', '2025-10-02 08:51:14+00:00', 'o4nrqr', 'fqyp', 's5bbp02e', -751275471, -1347802441, 1673584235, -2118135981, 2074205376, 'yytoo');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 1644911394, '2010-01-01 00:00:00+00:00', 't1__1984a3', '2021-12-11 04:26:48+00:00', 'hl72klex1', 'ji7zwau2', 'dwyrq13pyu78', 244829661, -1362461264, -904834265, -346339240, 1692174491, 'qi2rkf9v');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, 894242932, '2010-01-01 00:00:00+00:00', 't1__ae080b', '2023-11-01 15:52:25+00:00', '3d', 'qv0gcb98ozk', 'zbilyrkn', -688098735, 1784916884, 37673509, 834709651, -348113485, 'jswwlq7xb');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1350414441, '2023-03-07 13:22:39+00:00', '7', '2022-05-08 02:53:39+00:00', 'fdrz16n', 'jja', '5dh', 1583472758, 1449284300, -977470238, -1478247928, 1074760385, 't1afgog');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483643, -1957268147, '2010-01-01 00:00:00+00:00', 't1__ae080b', '2020-06-07 10:59:23+00:00', 't', 'mfg62g0v5q8q', 'j', -1139855872, -288338724, 1897687032, -241848752, 2004147439, 'tjpttg');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483642, -526633767, '2010-01-01 00:00:00+00:00', 't1__ae080b', '2024-06-27 07:12:45+00:00', 'zzbe8yvkv4', 'q7sx58b4', 'pmaus3auvmkr', 609771851, -1934017803, 1105964624, -663234145, -2013213247, '9mo7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-1, 440797047, '2010-01-01 00:00:00+00:00', 't1__1984a3', '2020-12-29 08:01:31+00:00', 'u06dza', '5rmkio18', 'i2hy0', 168442149, 1299171592, 2066302536, 24053253, -646944990, 'xxnja');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1, NULL, 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1, '2010-01-01 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.OwnerUserId, T1.DisplayName FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE STRFTIME('%Y', T1.CreationDate) = '2010' ORDER BY T2.FavoriteCount DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
(6, None)
*/

-- Prediction Query
SELECT id, ownerdisplayname FROM posts WHERE favoritecount = (SELECT MAX(favoritecount) FROM posts);

/*
Prediction Result:
(4, 'sr')
*/
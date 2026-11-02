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

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 226938182, 90119032, '2021-05-27 14:39:41+00:00', -1390245819, 1055976837, '4ji7zwa', 1, '2022-08-31 15:38:50+00:00', '2dwyrq13pyu7', 'd99rljsl0', -2031361952, 1649269347, -1116181514, 1, '2022-03-22 13:45:21+00:00', '2021-03-04 06:15:13+00:00', -227162283, '2021-05-26 08:15:06+00:00', '9v', 'x58pz');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483646, 710458518, 678047687, '2021-04-29 04:39:04+00:00', -197933860, 2111987706, 'p1q430', 5, '2023-08-17 20:15:35+00:00', 'jh3den8c68', '8vacx7', 1523825314, 2078438287, 0, 2, '2022-09-01 11:41:59+00:00', '2024-02-28 09:48:47+00:00', -290314193, '2025-10-08 08:31:18+00:00', '77', 'zo72');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -1928431425, 1303877941, '2025-11-30 16:40:04+00:00', 481546706, -1784554553, '2g0v5q8qd', 5, '2025-05-19 01:18:37+00:00', 'pe1', 'o22', 2004147439, -691774480, -1, 2, '2021-03-27 11:42:11+00:00', '2022-01-28 18:02:07+00:00', 1582582341, '2025-02-24 17:48:00+00:00', 'g6bno', '5zi36c');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, -1776877925, 1201273976, '2025-08-13 14:13:20+00:00', -1173368267, 382831862, '0', 5, '2025-09-08 19:36:12+00:00', 'z2zezjo7w', 'xd', 1999335832, -526612570, -1, 1, '2023-03-04 02:34:12+00:00', '2020-04-12 14:45:54+00:00', -405743609, '2020-06-02 03:52:50+00:00', 'j5', '3lq');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, 1339733032, -1556979799, '2024-02-22 11:40:18+00:00', -1125548818, 1497321728, '4gth2mnaj', 5, '2021-04-29 06:47:06+00:00', 'a3o', 'v8u', 618058035, 1553368934, 0, -2147483647, '2021-10-09 18:25:05+00:00', '2020-08-26 16:24:25+00:00', 1908593332, '2020-09-26 00:22:30+00:00', 'yz7zzb', '8y');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 600401919, -1437333179, '2022-06-06 02:35:43+00:00', -664303813, -1022641847, 'sk', 4, '2024-11-14 12:35:58+00:00', 'n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 5, '2023-10-02 15:43:02+00:00', '2023-03-21 21:13:18+00:00', 1115440883, '2023-05-25 17:04:36+00:00', 'sr', 'wbbp6luhvdlt');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 600401919, -1437333179, '2022-06-06 02:35:43+00:00', -664303813, -1022641847, 'sk', 6, '2024-11-14 12:35:58+00:00', 'n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 5, '2023-10-02 15:43:02+00:00', '2023-03-21 21:13:18+00:00', 1115440883, '2023-05-25 17:04:36+00:00', 'sr', 'wbbp6luhvdlt');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2010-01-01 00:00:00+00:00', 't1__df5793', '2024-02-19 01:18:26+00:00', 'wwqcg', 'k9n8c', 'pgu7vfe4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -443340271, '2010-01-01 00:00:00+00:00', 't1__df5793', '2025-10-02 08:51:14+00:00', 'o4nrqr', 'fqyp', 's5bbp02e', -751275471, -1347802441, 1673584235, -2118135981, 2074205376, 'yytoo');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -1529584866, '2010-01-01 00:00:00+00:00', 't1__df5793', '2020-10-30 07:33:08+00:00', 'd21vy9uxj4hw', 'd', 'lph2gn', 1968874827, -664193365, -1070063173, 555413010, 722884590, 'hncprjtu0dz');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1748371085, '2010-01-01 00:00:00+00:00', 't1__1a4866', '2020-10-20 06:14:04+00:00', '8n2f3', 'dqv0gcb98ozk', 'zbilyrkn', -688098735, 1784916884, 37673509, 834709651, -348113485, 'jswwlq7xb');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1350414441, '2023-03-07 13:22:39+00:00', '7', '2022-05-08 02:53:39+00:00', 'fdrz16n', 'jja', '5dh', 1583472758, 1449284300, -977470238, -1478247928, 1074760385, 't1afgog');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1, NULL, 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

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
SELECT Id, OwnerDisplayName FROM posts WHERE SUBSTRING(CreaionDate, 1, 4) = '2010' ORDER BY FavoriteCount DESC, posts.id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/
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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', 21, -1349201381, 'hvdlttilbnpr', 1, '2021-08-20 16:50:24+00:00', 'dposiie5unw', 'klfa9000t', 1408123494, -1964997180, 1149850321, 1, '2020-05-18 19:45:10+00:00', '2025-04-19 21:11:20+00:00', -1833165707, '2024-05-26 02:52:16+00:00', 'nium52zbu', '4nrq');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -792092619, -1492524358, '2021-01-22 00:53:52+00:00', 21, -629784617, 'v', 1, '2021-07-30 02:29:08+00:00', 'h2gn', 'q', -664193365, -1070063173, 555413010, 3, '2025-09-07 08:46:54+00:00', '2024-03-04 00:31:03+00:00', 580968159, '2021-10-14 14:41:11+00:00', 'p', 'jtu0d');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -1748371085, -1742081330, '2024-08-10 07:57:32+00:00', 21, -1255130038, '3d', 1, '2025-08-02 02:30:29+00:00', 'qv0gcb98ozk', 'zbilyrkn', -688098735, 1784916884, 37673509, 3, '2025-01-10 14:09:09+00:00', '2025-11-27 06:11:21+00:00', -1672720816, '2020-10-15 18:29:15+00:00', 'jswwlq7xb', '72fxa7ryfd');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -1259474148, 2011234363, '2021-04-25 14:26:05+00:00', 20, -2115841792, 'dh5ogrgj', 1, '2020-06-19 19:37:13+00:00', 'yzt1afgog', 'itsj3', -491938169, -106471771, 1235416111, 4, '2023-08-17 20:15:35+00:00', '2024-11-10 21:13:22+00:00', -1538707438, '2023-12-06 02:24:58+00:00', 'e', '8c68');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, 1774087382, 1732258051, '2024-05-22 05:48:31+00:00', 21, 1523825314, 'u5', 1, '2023-01-06 16:23:08+00:00', '1of77pzo72c', 'dctmf', 7929158, -1744557630, 1870300798, 3, '2024-03-11 08:01:44+00:00', '2025-11-17 07:39:50+00:00', -1021978385, '2025-05-19 01:18:37+00:00', 'pe1', 'o22');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1, 1, '2024-06-15 00:00:00+00:00', NULL, 1, 'value', 2, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, 1, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', 21, -1349201381, 'hvdlttilbnpr', 5, '2021-08-20 16:50:24+00:00', 'dposiie5unw', 'klfa9000t', 1408123494, -1964997180, 1149850321, 1, '2020-05-18 19:45:10+00:00', '2025-04-19 21:11:20+00:00', -1833165707, '2024-05-26 02:52:16+00:00', 'nium52zbu', '4nrq');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -2081315180, 1909986641, '2023-01-13 04:58:30+00:00', 21, -511185946, '13pyu', 6, '2024-06-05 19:22:34+00:00', 'd99rljsl0', '4', 1649269347, -1116181514, 1255852738, 5, '2021-03-04 06:15:13+00:00', '2023-10-21 02:54:45+00:00', -975213201, '2020-10-15 10:13:01+00:00', 'vqx58pz0f', '8jegd21vy9ux');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -2078052421, -512640349, '2021-06-12 16:42:05+00:00', 21, 32204797, 'k', 7, '2024-04-29 16:45:22+00:00', 'h', 'f8jswwl', 1255343543, -541746689, 1294666887, 2, '2023-03-26 06:11:01+00:00', '2020-09-26 17:28:32+00:00', 1427161052, '2022-05-09 09:35:03+00:00', 'z16nijjai5d', 'h5ogrgjd8yz');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, -435350511, 1992637800, '2022-08-17 19:55:37+00:00', 21, -1928431425, 'mfg62', 8, '2020-10-18 11:14:36+00:00', 'v5q8qdj', 'e1io', -241848752, 2004147439, -691774480, 2, '2021-03-27 11:42:11+00:00', '2022-01-28 18:02:07+00:00', 1582582341, '2025-02-24 17:48:00+00:00', 'g6bno', '5zi36c');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 1379859112, 195202164, '2022-06-11 14:45:41+00:00', 21, 1615073310, '7p2r94gth2m', 9, '2021-10-18 07:51:02+00:00', 'ajjla3okv8u', 'tmu2n', -1817527403, -1402164108, 2123471885, 4, '2025-08-19 19:51:44+00:00', '2023-03-18 11:45:17+00:00', -451030047, '2025-05-30 03:33:11+00:00', 'be8yvkv42q', '7sx58b4pma');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 418417917, '2021-11-17 08:00:56+00:00', 'fqyp5s5bbp0', '2025-09-22 03:26:15+00:00', 'eutliqa1', 'ryytoo3', '9hl7', 1178636309, -1390245819, 1055976837, 1775126557, -74849714, '7zw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 2123196517, '2025-11-10 22:24:59+00:00', 'w', '2024-12-22 09:14:04+00:00', 'rq13pyu', '8d99rljsl', 'b4yp5qi', -227162283, 2056419640, 222415430, 556727997, 1178000634, 'pz0f8jegd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 418417917, '2021-11-17 08:00:56+00:00', 'fqyp5s5bbp0', '2025-09-22 03:26:15+00:00', 'eutliqa1', 'ryytoo3', '9hl7', 1178636309, -1390245819, 1055976837, 1775126557, -74849714, '7zw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -1492524358, '2021-01-22 00:53:52+00:00', 'bdvlph', '2023-09-26 13:08:37+00:00', 'nd', 'wnqcx', '5hncprjtu0d', 401805964, -1485777725, -1255130038, -1762857309, 806170397, 'qv0gcb98ozk');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1250290042, '2020-11-06 22:27:04+00:00', 'grit', '2025-08-05 22:21:48+00:00', 'j3ayx', '1q43', '1jh3den', 357330522, -683007527, 2035306060, 1523825314, 2078438287, '5w1of7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1722106924, '2020-02-23 23:54:56+00:00', 'kf', '2025-08-13 14:13:20+00:00', 'acd0', '7z2zezjo7wg', 'd5ysxc', -405743609, -1935752926, -20116244, -176606723, -15162884, 'pim5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Age > 65, 1, 0)) AS REAL) * 100 / COUNT(T1.Id) FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T1.Score > 20;

/*
Gold Result:
(77.77777777777777,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN users.age > 65 THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(*) AS elderuserpostpercentage FROM posts INNER JOIN users ON posts.owneruserid = users.id WHERE posts.score > 5;

/*
Prediction Result:
(80.0,)
*/
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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', -2147483648, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, -2147483648, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -1031969798, -1106983592, '2022-06-06 01:51:46+00:00', 902551284, 2107872094, '02eutliqa11r', -2147483648, '2023-03-22 03:47:49+00:00', 'ytoo3o9hl7', 'klex14ji', -453362185, 481163439, 2123196517, -2147483648, '2025-11-10 22:24:59+00:00', '2020-06-29 05:47:52+00:00', 1485335077, '2024-12-22 09:14:04+00:00', 'rq13pyu', '8d99rljsl');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1692174491, -1025564911, '2023-10-21 02:54:45+00:00', -975213201, -705985602, 'x58pz0f8je', -2147483648, '2020-10-30 07:33:08+00:00', 'd21vy9uxj4hw', 'd', -736979194, 2103044118, -1642259219, -2147483648, '2020-12-04 21:49:29+00:00', '2021-09-30 11:37:26+00:00', 1968874827, '2022-12-08 23:34:02+00:00', 'qcx5', 'hncprjtu0dz');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -59984348, -664303813, '2022-03-24 16:30:12+00:00', -1981402255, -890215420, '9n8c4pgu7v', -2147483648, '2020-09-25 19:25:33+00:00', '4h', 'ia2yp', -1670923962, 700293388, 906324270, -2147483648, '2020-04-05 14:43:51+00:00', '2020-03-08 22:40:47+00:00', 1072996612, '2024-04-12 00:38:47+00:00', 'uhv', 'l');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -1364429300, -1257178728, '2022-04-12 01:47:28+00:00', 2087640001, 907682809, 'siie', -2147483648, '2024-02-29 12:08:41+00:00', 'nw6klf', 'a9000t5c4eci', 1149850321, -1833165707, 1155439218, -2147483648, '2021-02-10 21:10:52+00:00', '2022-09-29 20:25:58+00:00', -53231346, '2025-09-21 09:36:38+00:00', 'buo4nrq', 'rofqyp5s5b');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -1347802441, 1673584235, '2020-01-22 05:30:29+00:00', -314162272, 2137741668, 'ytoo3o9hl7', -2147483648, '2023-10-09 18:36:37+00:00', 'lex', '4ji7zwa', 2123196517, 364869063, -953437896, -2147483648, '2023-09-08 22:37:16+00:00', '2025-01-11 14:32:08+00:00', -1097120355, '2022-10-12 16:19:32+00:00', '8d99rljsl', 'b4yp5qi');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -705985602, 537874887, '2025-12-09 03:18:27+00:00', 1836127587, -1529584866, 'd2', -2147483648, '2023-09-10 09:37:01+00:00', 'y9uxj4', 'wb', -1929953647, 1581736075, -261132974, -2147483648, '2021-09-30 11:37:26+00:00', '2020-07-01 12:41:54+00:00', -1052964641, '2021-10-14 08:16:37+00:00', 'cx5hn', 'p');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, -792947627, -1898531797, '2024-06-08 14:05:00+00:00', 401805964, -1485777725, '8n2f3', -2147483648, '2025-11-06 14:42:57+00:00', 'q', '0gcb98', -1454058168, -2078052421, -512640349, -2147483648, '2021-06-12 16:42:05+00:00', '2025-03-26 10:17:14+00:00', 638024588, '2025-11-22 09:05:23+00:00', 'vck6ah0f8', 'sww');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, -541746689, 1294666887, '2023-03-26 06:11:01+00:00', -1888505890, 777149609, '16nijjai5dh', -2147483648, '2024-02-27 00:46:50+00:00', 'grgj', '8', -458359144, 600440952, 1568069663, -2147483648, '2020-09-12 13:47:57+00:00', '2020-11-06 22:27:04+00:00', -1194675273, '2022-05-19 02:17:07+00:00', 'tsj', 'ayxp1q43');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, -59984348, -664303813, '2022-03-24 16:30:12+00:00', -1981402255, -890215420, '9n8c4pgu7v', -2147483648, '2020-09-25 19:25:33+00:00', '4h', 'ia2yp', -1670923962, 700293388, 906324270, -2147483648, '2020-04-05 14:43:51+00:00', '2020-03-08 22:40:47+00:00', 1072996612, '2024-04-12 00:38:47+00:00', 'uhv', 'l');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

-- Inserting into table: votes --
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483648, 1, 902887186, '2011-01-01', -2147483648, 50);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483647, 4, -1485777725, '2011-01-01', -2147483648, 50);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483646, 4, -1762857309, '2011-01-01', -2147483648, 50);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483645, 4, -1454058168, '2011-01-01', -2147483648, 50);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483644, 4, -512640349, '2011-01-01', -2147483648, 50);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (2, 1, -1672720816, '2011-01-01', -2147483648, 50);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (3, 1, 138842628, '2011-01-01', -2147483648, 50);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483641, 1, 564390026, '2011-01-01', -2147483648, 1);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483640, 1, -1483100200, '2080-03-31', -2147483648, 50);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483639, 1, -1625552518, '2011-01-01', -2147483648, 50);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (4, 2, 1, NULL, -2147483648, 50);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (5, 5, 328305758, '1911-01-01', -2147483648, 1);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (6, 6, 1, NULL, -2147483648, 1);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (7, 7, 1, '2011-01-01', -2147483648, NULL);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (8, 8, 1, '1900-08-31', -2147483648, NULL);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (9, 9, 1, NULL, -2147483648, NULL);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (10, 10, -841692980, '2011-01-01', -2147483648, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM posts AS T1 INNER JOIN votes AS T2 ON T1.Id = T2.PostId WHERE T2.BountyAmount = 50 AND STRFTIME('%Y', T2.CreationDate) = '2011';

/*
Gold Result:
(9,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT posts.id) FROM posts INNER JOIN votes ON posts.id = votes.postid WHERE STRFTIME('%Y', votes.creationdate) = '2011' AND votes.bountyamount = 50;

/*
Prediction Result:
(3,)
*/
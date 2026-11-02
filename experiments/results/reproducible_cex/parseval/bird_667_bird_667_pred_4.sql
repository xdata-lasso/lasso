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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', -2147483648, '2020-03-11 00:23:16+00:00', 't1__6ad876', 'nprmdposii', -1823627488, -1209887326, -1399556171, -2147483648, '2020-01-18 08:28:25+00:00', '2024-12-31 04:19:17+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 742285925, -747753377, '2024-01-27 22:01:59+00:00', 1119186446, 781505063, 'rofqyp5s5b', -2147483648, '2020-03-11 14:09:37+00:00', 't1__6ad876', '02eu', -868774469, -1068298341, -314162272, -2147483648, '2023-03-22 03:47:49+00:00', '2024-10-18 05:00:47+00:00', -525979501, '2025-09-09 06:56:52+00:00', 'oo3o9hl72kle', 'x14ji7zwau2d');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-1, 244829661, -1362461264, '1969-12-31 23:59:59+00:00', -904834265, -346339240, 'yp5qi2rk', -2147483648, '2020-10-15 10:13:01+00:00', 't1__6ad876', 'vqx58pz0f', 176555546, -1937207087, 1675430660, -2147483648, '2022-11-21 09:24:31+00:00', '2023-04-27 18:28:48+00:00', -792092619, '2024-12-23 02:48:29+00:00', '4hw', 'd');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (0, 2103044118, -1642259219, '1970-01-01 00:00:00+00:00', 1298861365, 1968874827, 'nqcx5h', -2147483648, '2021-10-14 14:41:11+00:00', 't1__7e6e76', 'p', -988981234, -841004020, -361507387, -2147483648, '2023-05-14 17:39:51+00:00', '2024-06-08 14:05:00+00:00', 401805964, '2021-04-23 15:57:00+00:00', 'q8', 'n2f3dqv0gcb9');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 1443629118, -155284187, '2020-02-20 05:24:11+00:00', -1554531873, 982314585, 'kn6vc', -2147483648, '2021-05-17 23:21:59+00:00', 'ah0f8jsww', 'q7x', -541746689, 1294666887, -515895469, -2147483648, '2020-07-06 08:08:29+00:00', '2022-05-09 09:35:03+00:00', 777149609, '2025-05-15 17:08:24+00:00', '6nijjai', 'dh5ogrgj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', -2147483648, '2024-06-15 00:00:00+00:00', NULL, 'value', 1, 1, 1, -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

-- Inserting into table: postlinks --
INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (1, '2024-05-26 02:52:16+00:00', 1, 1, -1585009206);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483647, '2023-09-08 22:37:16+00:00', 2, 2, 392822403);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483646, '2023-04-21 03:11:26+00:00', 5, 5, 1129658414);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483645, '2020-11-22 11:14:57+00:00', 5, 2, -946046410);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483644, '2023-01-25 15:19:02+00:00', 5, 0, -106471771);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483643, '2025-04-12 14:20:03+00:00', 1, 5, -1538707438);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483642, '2024-08-17 10:42:21+00:00', 1, 2, 195720193);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (-2147483641, '2024-05-22 05:48:31+00:00', 1, -1, 1523825314);

INSERT INTO "postlinks" ("id", "creationdate", "postid", "relatedpostid", "linktypeid") VALUES (2, '2022-06-06 02:35:43+00:00', 3, 0, -664303813);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Title FROM posts AS T1 INNER JOIN postLinks AS T2 ON T2.PostId = T1.Id ORDER BY T1.CreaionDate, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('ah0f8jsww',)
*/

-- Prediction Query
SELECT DISTINCT posts.title FROM posts INNER JOIN postlinks ON posts.id = postlinks.postid ORDER BY postlinks.creationdate ASC, posts.title NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/
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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, NULL, '2023-01-01 01:00:00.000000', 'Samuel', NULL, 'default2', '2013', '2013', NULL, 0, NULL, 1, NULL, NULL), (0, 0, NULL, '%Y', '2013-10-27 00:00:00.000000', NULL, '%Y', 'default2', 0, NULL, 0, 1, 1, '%Y'), (2, 1, '2013-10-27 00:00:00.000000', '%Y', NULL, '%Y', NULL, '%Y', 1, NULL, 0, 0, 0, 'default1'), (3, 1, NULL, '2013', '2023-01-01 00:00:00.000000', '%Y', 'Samuel', 'default1', 1, NULL, 1, 1, NULL, '2013'), (4, NULL, NULL, NULL, NULL, '%Y', 'default1', 'Samuel', 1, 1, 1, NULL, 0, 'Samuel'), (5, NULL, '2023-01-01 01:00:00.000000', 'Samuel', '2023-01-01 00:00:00.000000', '2013', 'default1', 'default2', 0, NULL, 0, 0, 1, 'default1'), (6, 1, '2023-01-01 00:00:00.000000', 'Samuel', NULL, NULL, NULL, 'default1', 1, NULL, NULL, 1, NULL, '2013'), (7, 1, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', NULL, '%Y', '2013', NULL, 0, 0, 0, 0, '%Y');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (1, 5, 4, NULL, 1, NULL, NULL, NULL, 'default1', '2023-01-01 01:00:00.000000', 'default1', '2013', 0, NULL, 1, '2013-10-27 00:00:00.000000', '2013-10-27 00:00:00.000000', 0, '2023-01-01 01:00:00.000000', 'default1', 'default1'), (0, 4, 1, NULL, 0, NULL, NULL, 1, 'default1', '2023-01-01 01:00:00.000000', NULL, 'Samuel', 0, 0, 1, '2023-01-01 01:00:00.000000', '2013-10-27 00:00:00.000000', 0, NULL, 'default1', 'default1'), (2, 6, 6, NULL, 0, '2023-01-01 00:00:00.000000', 0, 0, 'default1', '2023-01-01 01:00:00.000000', NULL, 'default1', 1, 0, 0, NULL, NULL, 0, '2023-01-01 00:00:00.000000', 'Samuel', NULL), (3, 3, NULL, 0, 0, NULL, 1, 0, 'default2', '2013-10-27 00:00:00.000000', '2013', 'default1', NULL, 1, 1, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 1, '2023-01-01 01:00:00.000000', 'default1', '%Y'), (4, 5, 0, NULL, 0, '2013-10-27 00:00:00.000000', 0, 1, 'default1', '2023-01-01 00:00:00.000000', '%Y', 'default1', 0, 0, NULL, NULL, NULL, 0, '2013-10-27 00:00:00.000000', 'default2', '2013'), (5, NULL, 4, NULL, 1, '2023-01-01 00:00:00.000000', NULL, NULL, '%Y', '2023-01-01 01:00:00.000000', '2013', 'Samuel', 0, 1, 0, NULL, NULL, 1, '2023-01-01 01:00:00.000000', 'default2', 'default2'), (6, 2, 6, NULL, 1, '2023-01-01 00:00:00.000000', 1, 0, '2013', '2023-01-01 00:00:00.000000', '%Y', '%Y', NULL, NULL, 1, '2023-01-01 01:00:00.000000', NULL, NULL, '2023-01-01 01:00:00.000000', 'Samuel', 'default1'), (7, 4, 6, NULL, 1, '2013-10-27 00:00:00.000000', 0, NULL, 'default1', '2023-01-01 01:00:00.000000', 'Samuel', 'default2', NULL, 0, 1, '2023-01-01 01:00:00.000000', '2013-10-27 00:00:00.000000', 0, NULL, '2013', 'default1');
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (0, 0, 7, 1, 'default1', '2013-10-27 00:00:00.000000', '2013', 'default1', '%Y'), (1, 2, 5, 1, '2013', NULL, '2013', 'Samuel', 'default2'), (2, NULL, 5, 1, 'default1', '2023-01-01 00:00:00.000000', 'default2', 'default1', 'Samuel'), (3, 5, NULL, NULL, NULL, '2023-01-01 00:00:00.000000', 'default2', NULL, '2013'), (4, 4, 0, 0, NULL, '2023-01-01 00:00:00.000000', '2013', 'Samuel', '2013'), (5, 5, 1, NULL, 'Samuel', '2023-01-01 00:00:00.000000', NULL, 'default2', 'default2'), (6, 6, 6, NULL, 'Samuel', '2023-01-01 00:00:00.000000', '%Y', 'Samuel', 'default2'), (7, 7, NULL, 0, '%Y', '2023-01-01 00:00:00.000000', '2013', 'default1', '2013'), (8, 2, 1, 1, 'default1', '2013-10-27 00:00:00.000000', 'default1', 'default2', 'default2'), (9, 4, NULL, 1, 'default2', '2023-01-01 00:00:00.000000', 'Samuel', 'default1', 'default2'), (10, NULL, 2, 1, NULL, '2013-10-27 00:00:00.000000', 'Samuel', 'default1', '2013'), (11, 2, 4, 1, NULL, NULL, 'default2', '2013', 'default2'), (12, 6, 3, 1, '%Y', '2023-01-01 01:00:00.000000', NULL, 'default2', '%Y'), (13, 0, 0, 1, NULL, '2023-01-01 01:00:00.000000', 'Samuel', 'default1', '2013'), (14, 3, NULL, NULL, '2013', '2023-01-01 01:00:00.000000', '%Y', 'default2', '2013');
INSERT INTO badges (id, userid, name, date) VALUES (0, NULL, NULL, '2023-01-01 01:00:00.000000'), (1, 6, 'default2', '2023-01-01 00:00:00.000000'), (2, NULL, 'default1', '2023-01-01 01:00:00.000000'), (3, 5, 'default2', '2023-01-01 00:00:00.000000'), (4, 6, NULL, '2013-10-27 00:00:00.000000'), (5, 5, '%Y', '2013-10-27 00:00:00.000000'), (6, 4, NULL, '2023-01-01 01:00:00.000000'), (7, 6, 'default1', '2013-10-27 00:00:00.000000'), (8, 7, 'default1', NULL), (9, NULL, 'default1', '2023-01-01 00:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.PostId, T2.Name FROM postHistory AS T1 INNER JOIN badges AS T2 ON T1.UserId = T2.UserId WHERE T1.UserDisplayName = 'Samuel' AND STRFTIME('%Y', T1.CreationDate) = '2013' AND STRFTIME('%Y', T2.Date) = '2013';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Id, T3.Name FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id INNER JOIN badges AS T3 ON T2.Id = T3.UserId WHERE T2.DisplayName = 'Samuel' AND STRFTIME('%Y', T3.Date) = '2013';

/*
Prediction Result:
(2, None)
(6, None)
(7, None)
(2, 'default1')
(6, 'default1')
(7, 'default1')
*/
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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (59, 60, NULL, 'default1', NULL, 'default2', NULL, 'default2', 1, 59, 61, 0, 1, NULL), (61, 61, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', NULL, 'default1', 'default1', 60, 61, NULL, 1, 60, 'default1'), (0, NULL, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', NULL, NULL, 'default1', 1, 59, 61, NULL, 61, 'default1'), (60, 1, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', 'default2', 'default1', 59, 0, 60, 0, 0, NULL), (1, 61, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', NULL, NULL, NULL, 60, 0, 61, 0, 0, 'default1'), (2, NULL, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', 'default1', 'default2', 0, 0, 59, NULL, 0, 'default2'), (3, 61, '2023-01-01 01:00:00.000000', 'default2', NULL, 'default2', NULL, 'default2', 61, 0, 61, 59, 59, NULL);
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (59, 60, 61, 59, 1, '2023-01-01 01:00:00.000000', 0, 60, 'default1', '2023-01-01 00:00:00.000000', NULL, NULL, 60, 1, 1, NULL, '2023-01-01 00:00:00.000000', 61, '2023-01-01 00:00:00.000000', 'default2', 'default2'), (61, 1, 61, NULL, NULL, '2023-01-01 01:00:00.000000', 60, 61, NULL, NULL, 'default2', 'default1', 1, 0, 59, NULL, '2023-01-01 00:00:00.000000', 61, NULL, 'default1', 'default2'), (60, 0, 61, 60, 59, '2023-01-01 00:00:00.000000', 1, 59, 'default1', NULL, 'default2', 'default1', 60, 61, 0, NULL, '2023-01-01 00:00:00.000000', 59, '2023-01-01 00:00:00.000000', 'default2', 'default1');
INSERT INTO comments (id, postid, userid, score, text, creationdate, userdisplayname) VALUES (61, 59, 60, 61, NULL, '2023-01-01 00:00:00.000000', 'default1'), (59, 61, 0, 60, NULL, NULL, 'default2'), (1, NULL, 61, NULL, 'default2', NULL, 'default2'), (60, 60, 59, 1, 'default2', '2023-01-01 00:00:00.000000', 'default1'), (0, NULL, 1, 1, NULL, '2023-01-01 01:00:00.000000', 'default1'), (2, 61, 60, 0, NULL, '2023-01-01 01:00:00.000000', NULL), (3, 59, 60, 60, 'default2', NULL, NULL), (4, NULL, 60, 59, NULL, '2023-01-01 01:00:00.000000', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Title, T2.UserDisplayName FROM posts AS T1 INNER JOIN comments AS T2 ON T2.PostId = T2.Id WHERE T1.Score > 60;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.Title, T1.UserDisplayName FROM comments AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T1.Score > 60;

/*
Prediction Result:
(None, 'default1')
*/
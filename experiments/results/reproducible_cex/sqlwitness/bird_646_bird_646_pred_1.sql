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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (61, 61, '2023-01-01 01:00:00.000000', 'default1', NULL, 'default2', 'default2', NULL, 1, 1, 1, 59, 59, NULL), (0, 0, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'default1', NULL, 'default2', 1, 61, 61, 60, 61, NULL), (59, 60, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', NULL, 'default1', 'default1', 60, 0, NULL, 60, 0, 'default2'), (1, 59, '2023-01-01 01:00:00.000000', 'default1', NULL, 'default2', 'default1', 'default1', 59, NULL, 60, 1, 60, 'default1'), (60, NULL, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', NULL, NULL, NULL, 60, 61, 0, NULL, 1, 'default1');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (0, 61, 0, 59, 0, '2023-01-01 00:00:00.000000', 0, 1, 'default1', NULL, NULL, NULL, 1, 1, 61, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 61, '2023-01-01 00:00:00.000000', 'default1', 'default1'), (1, 59, 60, 60, NULL, '2023-01-01 00:00:00.000000', NULL, 59, NULL, NULL, 'default1', 'default1', 60, NULL, 61, '2023-01-01 01:00:00.000000', NULL, NULL, '2023-01-01 01:00:00.000000', 'default2', 'default2'), (60, NULL, 0, 0, 60, '2023-01-01 00:00:00.000000', 61, 1, NULL, '2023-01-01 00:00:00.000000', 'default2', 'default1', 59, 59, 60, '2023-01-01 00:00:00.000000', NULL, 60, '2023-01-01 01:00:00.000000', NULL, 'default2'), (59, NULL, 1, 59, 1, '2023-01-01 00:00:00.000000', 0, 60, 'default2', '2023-01-01 01:00:00.000000', 'default1', NULL, 59, 61, 0, NULL, '2023-01-01 01:00:00.000000', 0, NULL, NULL, 'default1'), (61, 0, 1, 60, 61, '2023-01-01 01:00:00.000000', NULL, 1, NULL, '2023-01-01 00:00:00.000000', NULL, NULL, 60, NULL, 0, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 0, '2023-01-01 01:00:00.000000', 'default1', NULL);
INSERT INTO comments (id, postid, userid, score, text, creationdate, userdisplayname) VALUES (0, 60, 61, 60, 'default2', '2023-01-01 00:00:00.000000', 'default2'), (1, 0, 0, 59, 'default1', '2023-01-01 01:00:00.000000', 'default2'), (60, 1, 59, 61, NULL, NULL, 'default2'), (61, NULL, 59, 60, NULL, '2023-01-01 01:00:00.000000', 'default1'), (59, 59, NULL, 1, 'default2', '2023-01-01 01:00:00.000000', 'default2'), (2, 60, 1, 1, 'default1', NULL, 'default1'), (3, NULL, 59, 1, 'default1', '2023-01-01 00:00:00.000000', 'default2'), (4, 1, 61, 0, 'default2', '2023-01-01 01:00:00.000000', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Title, T2.UserDisplayName FROM posts AS T1 INNER JOIN comments AS T2 ON T2.PostId = T2.Id WHERE T1.Score > 60;

/*
Gold Result:
('default2', 'default2')
*/

-- Prediction Query
SELECT posts.Title, comments.UserDisplayName FROM comments INNER JOIN posts ON comments.PostId = posts.Id WHERE comments.Score > 60;

/*
Prediction Result:
('default1', 'default2')
*/
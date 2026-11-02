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
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (60, NULL, NULL, NULL, 59, '2023-01-01 00:00:00.000000', 61, 59, 'default2', '2023-01-01 01:00:00.000000', NULL, 'default2', 61, 1, 1, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 1, NULL, 'default1', 'default2'), (0, NULL, NULL, 1, 61, NULL, 59, 61, 'default2', NULL, 'default2', 'default1', 60, 0, NULL, NULL, '2023-01-01 01:00:00.000000', 59, '2023-01-01 01:00:00.000000', 'default1', 'default2'), (1, NULL, NULL, 1, 1, NULL, 60, 59, NULL, '2023-01-01 00:00:00.000000', 'default1', 'default1', 59, 1, 1, NULL, NULL, 1, '2023-01-01 00:00:00.000000', 'default1', 'default2'), (61, NULL, NULL, NULL, 1, '2023-01-01 01:00:00.000000', 1, 61, NULL, '2023-01-01 01:00:00.000000', 'default2', 'default2', 1, 60, 59, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', NULL, NULL, 'default2', 'default1'), (59, NULL, NULL, 0, 60, '2023-01-01 01:00:00.000000', 1, 59, 'default1', '2023-01-01 01:00:00.000000', 'default1', 'default1', NULL, 0, NULL, '2023-01-01 01:00:00.000000', NULL, 0, '2023-01-01 00:00:00.000000', NULL, 'default1'), (2, NULL, NULL, 61, 60, '2023-01-01 00:00:00.000000', 1, 60, NULL, '2023-01-01 01:00:00.000000', NULL, 'default1', NULL, 0, 60, NULL, '2023-01-01 01:00:00.000000', 60, NULL, 'default2', 'default2'), (3, NULL, NULL, NULL, 59, NULL, 59, 60, 'default2', '2023-01-01 01:00:00.000000', 'default1', 'default2', 1, 61, 61, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 59, '2023-01-01 01:00:00.000000', NULL, 'default2'), (4, NULL, NULL, NULL, 59, '2023-01-01 01:00:00.000000', 59, 60, 'default1', '2023-01-01 00:00:00.000000', 'default1', NULL, 61, 59, 61, NULL, '2023-01-01 01:00:00.000000', 0, NULL, NULL, 'default2');
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (0, 1, NULL, 60, 'default2', '2023-01-01 00:00:00.000000', 'default1', 'default2', 'default1'), (1, NULL, NULL, 0, 'default2', '2023-01-01 01:00:00.000000', NULL, 'default1', 'default2'), (61, 2, NULL, 61, 'default1', '2023-01-01 01:00:00.000000', 'default1', 'default2', 'default1'), (59, 2, NULL, 60, NULL, NULL, 'default2', 'default2', 'default1'), (60, 2, NULL, 61, 'default1', NULL, 'default2', 'default2', NULL), (2, NULL, NULL, 60, 'default2', '2023-01-01 00:00:00.000000', NULL, 'default1', 'default1'), (3, NULL, NULL, NULL, 'default2', '2023-01-01 01:00:00.000000', 'default1', NULL, 'default1'), (4, 0, NULL, 59, 'default2', NULL, 'default2', 'default1', NULL), (5, 4, NULL, 59, 'default1', NULL, 'default2', 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PostId, UserId FROM postHistory WHERE PostId IN (SELECT Id FROM posts WHERE Score > 60);

/*
Gold Result:
*/

-- Prediction Query
SELECT Id AS post_id, OwnerUserId AS user_id FROM posts WHERE Score > 60;

/*
Prediction Result:
(60, None)
*/
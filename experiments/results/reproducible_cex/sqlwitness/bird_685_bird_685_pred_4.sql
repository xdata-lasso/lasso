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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 0, NULL, 'Computer Game Datasets', '2023-01-01 01:00:00.000000', 'default2', 'Computer game datasets', 'Computer Game Datasets', 0, NULL, 0, 1, 0, 'Computer game datasets'), (0, 0, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', 'Computer Game Datasets', NULL, 'default1', 1, NULL, NULL, NULL, NULL, 'default1'), (2, 0, '2023-01-01 00:00:00.000000', 'Computer Game Datasets', NULL, 'Computer game datasets', 'Computer Game Datasets', 'Computer game datasets', NULL, 1, 1, NULL, NULL, 'default2'), (3, NULL, NULL, 'Computer Game Datasets', NULL, NULL, 'default1', 'default1', NULL, NULL, 1, 0, 1, 'default1');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (0, 2, 3, 0, 1, '2023-01-01 00:00:00.000000', 0, 1, NULL, NULL, 'default1', 'Computer Game Datasets', 0, 0, 0, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', NULL, NULL, 'default1', 'default1'), (1, 3, 2, 1, 1, '2023-01-01 01:00:00.000000', 1, 0, 'Computer Game Datasets', '2023-01-01 00:00:00.000000', 'Computer game datasets', NULL, 1, NULL, NULL, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 0, NULL, 'default1', 'default2');
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (1, 1, 1, 1, 'default2', '2023-01-01 01:00:00.000000', 'Computer game datasets', 'default2', 'default1'), (0, 0, 0, NULL, 'default2', '2023-01-01 00:00:00.000000', 'default2', 'default2', NULL), (2, NULL, 1, 1, 'Computer game datasets', NULL, 'Computer Game Datasets', 'Computer game datasets', NULL), (3, NULL, 3, 1, 'default2', '2023-01-01 01:00:00.000000', 'default1', NULL, 'default2'), (4, NULL, NULL, 0, 'Computer game datasets', NULL, NULL, 'Computer Game Datasets', 'Computer Game Datasets'), (5, 0, NULL, 0, NULL, '2023-01-01 00:00:00.000000', 'default1', 'Computer Game Datasets', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.ViewCount, T3.DisplayName FROM postHistory AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id INNER JOIN users AS T3 ON T2.LastEditorUserId = T3.Id WHERE T1.Text = 'Computer Game Datasets';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.ViewCount, T2.DisplayName FROM posts AS T1 JOIN users AS T2 ON T1.LastEditorUserId = T2.Id WHERE T1.Title = 'Computer game datasets';

/*
Prediction Result:
(0, 'Computer Game Datasets')
*/
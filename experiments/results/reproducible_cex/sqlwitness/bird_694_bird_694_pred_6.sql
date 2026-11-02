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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (9, 10, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default2', NULL, 'Analysing wind data with R', 1, 10, 9, 1, 0, 'default2'), (1, 2, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'default1', 'Analysing wind data with R', NULL, 2, 11, 11, NULL, 11, NULL), (11, 11, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'default1', 'default2', 'Analysing wind data with R', NULL, 0, NULL, NULL, 9, NULL), (0, NULL, '2023-01-01 01:00:00.000000', 'default2', NULL, 'default1', 'Analysing wind data with R', 'default2', NULL, 2, 0, 10, 1, 'default1'), (2, 2, '2023-01-01 01:00:00.000000', NULL, NULL, NULL, 'default1', 'default2', 1, 9, 0, NULL, 9, NULL);
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (11, 11, 2, 2, NULL, '2023-01-01 00:00:00.000000', 11, 1, 'default2', NULL, 'default1', 'Analysing wind data with R', NULL, NULL, 0, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 0, '2023-01-01 00:00:00.000000', 'Analysing wind data with R', 'Analysing wind data with R'), (2, 1, 0, 10, 2, '2023-01-01 01:00:00.000000', 0, 9, NULL, NULL, NULL, 'Analysing wind data with R', 9, 11, 10, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 9, '2023-01-01 00:00:00.000000', 'default1', 'default1'), (1, 2, 9, 0, 1, '2023-01-01 00:00:00.000000', 9, NULL, 'Analysing wind data with R', '2023-01-01 01:00:00.000000', 'default1', 'Analysing wind data with R', 1, NULL, 0, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 2, '2023-01-01 01:00:00.000000', NULL, 'default2'), (10, 2, NULL, 10, 2, NULL, 11, NULL, 'default2', '2023-01-01 00:00:00.000000', 'default2', 'default2', 2, 10, 1, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 1, NULL, 'default2', 'default2'), (9, 1, 1, NULL, NULL, NULL, 9, 10, 'Analysing wind data with R', NULL, 'Analysing wind data with R', 'default1', 0, 10, 9, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 1, '2023-01-01 01:00:00.000000', 'Analysing wind data with R', NULL), (0, 2, 0, 11, 11, '2023-01-01 01:00:00.000000', NULL, 1, 'Analysing wind data with R', '2023-01-01 01:00:00.000000', NULL, NULL, 0, 9, NULL, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 2, NULL, NULL, NULL), (3, NULL, 2, NULL, 10, '2023-01-01 00:00:00.000000', 1, 10, 'default1', '2023-01-01 01:00:00.000000', 'default2', 'default1', 10, 1, 1, '2023-01-01 01:00:00.000000', NULL, 1, '2023-01-01 00:00:00.000000', NULL, 'default2'), (4, 2, 1, NULL, 11, '2023-01-01 01:00:00.000000', 11, NULL, NULL, NULL, 'Analysing wind data with R', 'default1', 10, 0, 2, NULL, '2023-01-01 00:00:00.000000', 0, '2023-01-01 01:00:00.000000', NULL, 'Analysing wind data with R'), (5, 0, 2, 10, 9, NULL, 10, 0, NULL, '2023-01-01 00:00:00.000000', 'default2', NULL, 10, 1, NULL, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 2, '2023-01-01 00:00:00.000000', 'default1', NULL);
INSERT INTO comments (id, postid, userid, score, text, creationdate, userdisplayname) VALUES (2, 11, NULL, 9, 'default2', '2023-01-01 00:00:00.000000', NULL), (1, 11, 1, NULL, NULL, NULL, NULL), (0, 4, 2, 9, 'default1', '2023-01-01 00:00:00.000000', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Text, T1.DisplayName FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN comments AS T3 ON T2.Id = T3.PostId WHERE T2.Title = 'Analysing wind data with R' ORDER BY T1.CreationDate DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('default1', 'default2')
*/

-- Prediction Query
SELECT comments.text, comments.userdisplayname FROM comments INNER JOIN posts ON comments.postid = posts.id WHERE posts.title = 'Analysing wind data with R' ORDER BY comments.creationdate DESC, comments.id NULLS LAST, posts.id NULLS LAST LIMIT 10;

/*
Prediction Result:
('default1', None)
*/
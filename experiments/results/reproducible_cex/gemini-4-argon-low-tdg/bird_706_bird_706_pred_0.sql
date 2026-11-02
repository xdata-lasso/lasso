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
-- DATASET 1
-- Tests LIKE pattern boundaries (exact match, prefix, suffix, middle, non-match) and DISTINCT vs ALL with duplicate comment texts.
INSERT INTO users (Id, DisplayName) VALUES (1, 'User1');
INSERT INTO posts (Id, OwnerUserId, Title, Body) VALUES (1, 1, 'linear regression', 'Body 1');
INSERT INTO posts (Id, OwnerUserId, Title, Body) VALUES (2, 1, 'linear regression in R', 'Body 2');
INSERT INTO posts (Id, OwnerUserId, Title, Body) VALUES (3, 1, 'Understanding linear regression', 'Body 3');
INSERT INTO posts (Id, OwnerUserId, Title, Body) VALUES (4, 1, 'How linear regression works', 'Body 4');
INSERT INTO posts (Id, OwnerUserId, Title, Body) VALUES (5, 1, 'logistic regression', 'Body 5');
INSERT INTO posts (Id, OwnerUserId, Title, Body) VALUES (6, 1, NULL, 'Body 6');
INSERT INTO comments (Id, PostId, UserId, Text) VALUES (1, 1, 1, 'Exact match comment');
INSERT INTO comments (Id, PostId, UserId, Text) VALUES (2, 2, 1, 'Prefix match comment');
INSERT INTO comments (Id, PostId, UserId, Text) VALUES (3, 3, 1, 'Suffix match comment');
INSERT INTO comments (Id, PostId, UserId, Text) VALUES (4, 4, 1, 'Middle match comment');
INSERT INTO comments (Id, PostId, UserId, Text) VALUES (5, 4, 1, 'Middle match comment');
INSERT INTO comments (Id, PostId, UserId, Text) VALUES (6, 5, 1, 'Non-matching post comment');
INSERT INTO comments (Id, PostId, UserId, Text) VALUES (7, 6, 1, 'Null title post comment');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Text FROM comments AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T2.Title LIKE '%linear regression%';

/*
Gold Result:
('Exact match comment',)
('Prefix match comment',)
('Suffix match comment',)
('Middle match comment',)
('Middle match comment',)
*/

-- Prediction Query
SELECT T2.Text FROM posts AS T1 INNER JOIN comments AS T2 ON T1.Id = T2.PostId WHERE T1.Title = 'How can I adapt ANOVA for binary data?';

/*
Prediction Result:
*/
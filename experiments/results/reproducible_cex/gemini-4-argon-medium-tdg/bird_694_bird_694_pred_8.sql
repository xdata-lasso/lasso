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
-- Tests basic join paths, incorrect join conditions (e.g., LastEditorUserId vs OwnerUserId, Comment.UserId vs OwnerUserId), column projections (DisplayName vs OwnerDisplayName/UserDisplayName, Text vs Body/Title), and ordering by T1.CreationDate DESC vs T2/T3 CreationDate or ASC.
INSERT INTO users (Id, CreationDate, DisplayName) VALUES (1, '2020-01-01 10:00:00', 'OldUser_PostOwner');
INSERT INTO users (Id, CreationDate, DisplayName) VALUES (2, '2023-05-15 12:00:00', 'NewUser_TargetPostOwner');
INSERT INTO users (Id, CreationDate, DisplayName) VALUES (3, '2024-01-01 00:00:00', 'NewestUser_CommenterAndEditor');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title, Body, CreaionDate, OwnerDisplayName) VALUES (10, 1, 3, 'Analysing wind data with R', 'Body of post 10', '2023-12-01 00:00:00', 'FakeOwnerDisplay1');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title, Body, CreaionDate, OwnerDisplayName) VALUES (20, 2, 1, 'Analysing wind data with R', 'Body of post 20', '2021-01-01 00:00:00', 'FakeOwnerDisplay2');
INSERT INTO comments (Id, PostId, UserId, Text, CreationDate, UserDisplayName) VALUES (100, 10, 3, 'Comment on older user post', '2024-01-02 00:00:00', 'FakeCommentUser1');
INSERT INTO comments (Id, PostId, UserId, Text, CreationDate, UserDisplayName) VALUES (200, 20, 1, 'Target comment text', '2021-01-02 00:00:00', 'FakeCommentUser2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Text, T1.DisplayName FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN comments AS T3 ON T2.Id = T3.PostId WHERE T2.Title = 'Analysing wind data with R' ORDER BY T1.CreationDate DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Target comment text', 'NewUser_TargetPostOwner')
*/

-- Prediction Query
SELECT c.Text, c.UserDisplayName FROM posts AS p JOIN comments AS c ON p.Id = c.PostId WHERE p.Title = 'Analysing wind data with R' ORDER BY c.CreationDate DESC, p.id NULLS LAST, c.id NULLS LAST LIMIT 10;

/*
Prediction Result:
('Comment on older user post', 'FakeCommentUser1')
('Target comment text', 'FakeCommentUser2')
*/
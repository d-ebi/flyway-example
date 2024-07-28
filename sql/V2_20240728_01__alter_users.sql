ALTER TABLE ${global-env}.users RENAME COLUMN name TO full_name;
ALTER TABLE ${global-env}.users ADD COLUMN first_name VARCHAR(50);
ALTER TABLE ${global-env}.users ADD COLUMN last_name VARCHAR(50);

COMMENT ON TABLE ${global-env}.users IS 'ユーザ情報を管理するテーブル';
COMMENT ON COLUMN ${global-env}.users.full_name IS 'ユーザのフルネーム';
COMMENT ON COLUMN ${global-env}.users.first_name IS 'ユーザの名';
COMMENT ON COLUMN ${global-env}.users.last_name IS 'ユーザの姓';

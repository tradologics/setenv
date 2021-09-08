# Secrets


Manage `.env` file secrets for various GitHub projects.

### 1. Setup:

You'll need an access token as described in this [GitHub Help article](https://help.github.com/articles/creating-an-access-token-for-command-line-use).

**1.** Download `secrets` (bash file) and place it in `/usr/local/bin/` as an executable file:

```bash
$ cd <FILE-LOCATION>
$ chmod +x ./secrets
$ mv ./secrets /usr/local/bin/
```

2. Edit `.bashrc` to include your secrets repository (make it private!) and your token:

```bash
export SECRETS_REPO=<USERNAME>/<SECRETS-REPO>
export SECRETS_TOKEN=ghp_v4v78d73f9a03a694f1ca8f3488911ec2ec3
```

### 2. Create secrets

For every project, create its `.env` file for a GitHub repository as `user/repo`. 
For example:

1. For the GitHub project `someproj` for user `someuser`, create a file named `someuser/someproj`.
1. For the GitHub project `yourproj` for your user (aka `youruser`), create a file named `youruser/yourproj`.


### 3. Use

To fetch your project secrets, run `secrets` inside the project directory on your server or local machine before running your project.

For example:

```bash
$ cd yourproj
$ secrets && npm start
```

This will fetch the latest data `github.com/yourproj/secrets/yourproj/yourproj` and place it in `.env`.

### 4. Variations

You can also explicitly use variations of your `.env` file by creating adding a postfix and specifing it when running secrets.

For example, to use `youruser/yourproj-prod`, run:

```bash
$ cd yourproj
$ secrets prod && npm start
```

To use `youruser/yourproj-stage`, run:

```bash
$ cd yourproj
$ secrets stage && npm start
```

Etc.

### Enjoy!

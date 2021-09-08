# setenv


Manage `.env` files for various GitHub projects.

### 1. Setup

You'll need an access token as described in this [GitHub Help article](https://help.github.com/articles/creating-an-access-token-for-command-line-use).

**1.** Download `setenv.sh` (bash file) and place it in `/usr/local/bin/setenv ` as an executable file:

```bash
$ cd <FILE-LOCATION>
$ chmod +x ./setenv.sh
$ mv ./setenv.sh /usr/local/bin/setenv
```

2. Edit `.bashrc` to include your "env" repository (make it private!) and your token:

```bash
export ENV_REPO=<USERNAME>/<ENV-REPO>
export ENV_TOKEN=ghp_v4v78d73f9a03a694f1ca8f3488911ec2ec3
```

### 2. Create `.env` files

For every project, create its `.env` file for a GitHub repository as `user/repo`. 
For example:

1. For the GitHub project `someproj` for user `someuser`, create a file named `someuser/someproj`.
1. For the GitHub project `yourproj` for your user (aka `youruser`), create a file named `youruser/yourproj`.


### 3. Use

To fetch your project `.env` file, run `setenv` inside the project directory on your server or local machine before running your project.

For example:

```bash
$ cd yourproj
$ setenv && npm start
```

This will fetch the latest data `github.com/yourproj/setenv-repo/yourproj/yourproj` and place it in `.env`.

### 4. Variations

You can also explicitly use variations of your `.env` file by creating adding a postfix and specifing it when running `setenv`.

For example, to use `youruser/yourproj-prod`, run:

```bash
$ cd yourproj
$ setenv prod && npm start
```

To use `youruser/yourproj-stage`, run:

```bash
$ cd yourproj
$ setenv stage && npm start
```

Etc.

### 5. Clear

To clear the working `.env` file, run:

```bash
$ setenv --clear
```

### Enjoy!

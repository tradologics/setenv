[ -f ~/.bashrc ] && source ~/.bashrc
if [[ -z "$ENV_REPO" || -z "$ENV_TOKEN" ]]; then
    echo "FAILED! ENV_REPO and/or ENV_TOKEN not set"
    exit 0
fi

TIMESTAMP=$(date +%s)

# get config path
ENV_DIR=$(pwd)

# get config postfix
POSTFIX="-$1"
if [ -z "$1" ]; then
    POSTFIX=""
fi

ENV_FILE=$(git config --get remote.origin.url | sed 's/.*github\.com\///' | sed 's/.*\://' | sed 's/\.git.*//')
if [ -z "$ENV_FILE" ]; then
    echo "FAILED! Pass secrets path or run from within a repository."
    exit 0
fi
ENV_DIR=$(git rev-parse --show-toplevel)


if [ "$POSTFIX" == "---clear" ]; then
    rm $ENV_DIR/.env
    exit 0;
fi

$ENV_FILE=$ENV_FILE$POSTFIX

curl -s -o $TIMESTAMP \
    -H "Authorization: token $ENV_TOKEN" \
    -H 'Accept: application/vnd.github.v3.raw' \
    https://api.github.com/repos/$ENV_REPO/contents/$ENV_FILE$POSTFIX

OK=$(cat $TIMESTAMP | grep '"message": "Not Found",')
if [ "$OK" ]; then
    echo "FAILED! Secret '$ENV_FILE' not found."
    rm $TIMESTAMP
    exit 0;
fi

mv $TIMESTAMP $ENV_DIR/.env

echo "Copied $ENV_FILE to .env"

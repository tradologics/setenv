[ -f ~/.bashrc ] && source ~/.bashrc
if [[ -z "$SECRETS_REPO" || -z "$SECRETS_TOKEN" ]]; then
    echo "FAILED! SECRETS_REPO and/or SECRETS_TOKEN not set"
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


if [ -z "$SECRETS_ENV" ]; then
    SECRETS_ENV=$(git config --get remote.origin.url | sed 's/.*github\.com\///' | sed 's/.*\://' | sed 's/\.git.*//')
    if [ -z "$SECRETS_ENV" ]; then
        echo "FAILED! Pass secrets path or run from within a repository."
        exit 0
    fi
    ENV_DIR=$(git rev-parse --show-toplevel)
fi

curl -s -o $TIMESTAMP \
    -H "Authorization: token $SECRETS_TOKEN" \
    -H 'Accept: application/vnd.github.v3.raw' \
    https://api.github.com/repos/$SECRETS_REPO/contents/$SECRETS_ENV$POSTFIX

OK=$(cat $TIMESTAMP | grep '"message": "Not Found",')
if [ "$OK" ]; then
    echo "FAILED! Secret '$SECRETS_ENV' not found."
    rm $TIMESTAMP
    exit 0;
fi

mv $TIMESTAMP $ENV_DIR/.env

echo "Copied $SECRETS_ENV to .env..."

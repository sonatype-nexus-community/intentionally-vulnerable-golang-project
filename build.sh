function isinstalled {
  if command -v "$1";
  then
    true
  else
    false
  fi
}

# doing this to make this work locally since 99% of the times most dev machines already have curl and might not have apt-get
if isinstalled "curl"
then
  echo "curl already installed moving on"
else
  apt-get update && apt install -y curl
fi

if [ -z ${NANCY_VERSION+x} ];
then echo "NANCY_VERSION is unset, setting it for you now";
  NANCY_VERSION=v0.1.15
else
  echo "NANCY_VERSION is set to '$NANCY_VERSION'"
fi


mkdir -p /tmp/tools
if [[ "$OSTYPE" == "darwin"* ]]; then
  curl -s -L "https://github.com/sonatype-nexus-community/nancy/releases/download/$NANCY_VERSION/nancy-darwin.amd64-$NANCY_VERSION" -o "/tmp/tools/nancy"
else
  curl -s -L "https://github.com/sonatype-nexus-community/nancy/releases/download/$NANCY_VERSION/nancy-linux.amd64-$NANCY_VERSION" -o "/tmp/tools/nancy"
fi
chmod +x /tmp/tools/nancy

set -e
DEP_EXIT_CODE=0
SUM_EXIT_CODE=0
LIST_EXIT_CODE=0

/tmp/tools/nancy Gopkg.lock || DEP_EXIT_CODE=$?
/tmp/tools/nancy go.sum || SUM_EXIT_CODE=$?
GO111MODULE=on go list -m all | /tmp/tools/nancy || LIST_EXIT_CODE=$?

echo "go list exit code : $LIST_EXIT_CODE"
echo "go sum exit code : $SUM_EXIT_CODE"
echo "dep exit code : $DEP_EXIT_CODE"


if [[ "$LIST_EXIT_CODE" -eq 0 || "$SUM_EXIT_CODE" -eq 0 || "$DEP_EXIT_CODE" -eq 0 ]]
then
  echo "One of the above nancy tests actually passed....that means the project is no longer vulnerable and thats an issue"
  exit 1
else
  echo "YAH!!! :) Still vulnerable....usually not something you are happy about"
  exit 0
fi

#!/bin/bash

set -x

PROJECT_KEY="${PROJECT_KEY:-ConsoleApplication1}"
PROJECT_NAME="${PROJECT_NAME:-ConsoleApplication1}"
PROJECT_VERSION="${PROJECT_VERSION:-1.0}"
SONAR_HOST="${HOST:-http://localhost:9000}"
SONAR_LOGIN_KEY="${LOGIN_KEY:-admin}"

mono /opt/sonar-scanner-msbuild/SonarScanner.MSBuild.exe begin /d:sonar.host.url=$SONAR_HOST /d:sonar.login=$SONAR_LOGIN_KEY /k:$PROJECT_KEY /n:"$PROJECT_NAME" /v:$PROJECT_VERSION
    - dotnet build $SOLUTION_FILE  --configuration Release
    - echo !!!done build
    - echo start tests
    - find . -name "*.Test.csproj" -type f | xargs -n 1 -I '{}' bash -c 'echo !!test {} && dotnet test {}'
mono /opt/sonar-scanner-msbuild/SonarScanner.MSBuild.exe end /d:sonar.login=$SONAR_LOGIN_KEY

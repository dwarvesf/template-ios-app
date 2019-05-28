
function read_param () {
    TEMP_INPUT=""
    while [ "$TEMP_INPUT" == "" ]
    do
        read -p "Enter $1: " TEMP_INPUT
    done
    eval "$2='$TEMP_INPUT'"
}

function replace_content_file () {
    local FILE_NAME=$1
    local OLD=$2
    local NEW=$3
    sed "s/${OLD}/${NEW}/g" $FILE_NAME > $FILE_NAME.bak
    mv -f $FILE_NAME.bak $FILE_NAME
    rm -f $FILE_NAME.bak
}

BASE_PROJECT_NAME="TemplateProject"
BASE_BUNDLE_PROJECT_ID="com.dwarvesv.TemplateProject"
NEW_PROJECT_NAME="TemplateProject"
BUNDLE_PROJECT_ID="com.dwarvesv.TemplateProject"

echo "iOS template project setup script"
echo "================================="
echo "--> Input initialize values"

read_param "project name ($BASE_PROJECT_NAME)" NEW_PROJECT_NAME
echo $NEW_PROJECT_NAME

read_param "bundle id ($BASE_BUNDLE_PROJECT_ID)" BUNDLE_PROJECT_ID
echo $BUNDLE_PROJECT_ID

## Init project params
TEST_STR="Tests"
DEV_STR="Dev"
XCODEPROJ_FILE="./$BASE_PROJECT_NAME.xcodeproj"
NEW_XCODEPROJ_FILE="./$NEW_PROJECT_NAME.xcodeproj"
PBPROJECT_FILE="$XCODEPROJ_FILE/project.pbxproj"
SCHEMA_FILE="$XCODEPROJ_FILE/xcshareddata/xcschemes/$BASE_PROJECT_NAME.xcscheme"
DEV_SCHEMA_FILE="$XCODEPROJ_FILE/xcshareddata/xcschemes/$BASE_PROJECT_NAME$DEV_STR.xcscheme"
WORKSPACE_DATA_FILE="$XCODEPROJ_FILE/project.xcworkspace/contents.xcworkspacedata"
NEW_SCHEMA_FILE="$XCODEPROJ_FILE/xcshareddata/xcschemes/$NEW_PROJECT_NAME.xcscheme"
NEW_DEV_SCHEMA_FILE="$XCODEPROJ_FILE/xcshareddata/xcschemes/$NEW_PROJECT_NAME$DEV_STR.xcscheme"

echo "--> Modify $XCODEPROJ_FILE content"

### Replace bundle id
replace_content_file $PBPROJECT_FILE $BASE_BUNDLE_PROJECT_ID $BUNDLE_PROJECT_ID

### Replace project name
replace_content_file $PBPROJECT_FILE $BASE_PROJECT_NAME $NEW_PROJECT_NAME

### Replace workspace data
replace_content_file $WORKSPACE_DATA_FILE $BASE_PROJECT_NAME $NEW_PROJECT_NAME

### Replace schema file
replace_content_file $SCHEMA_FILE $BASE_PROJECT_NAME $NEW_PROJECT_NAME

### Replace dev schema file
replace_content_file $DEV_SCHEMA_FILE $BASE_PROJECT_NAME $NEW_PROJECT_NAME

### Rename schema files
mv -f $SCHEMA_FILE $NEW_SCHEMA_FILE
mv -f $DEV_SCHEMA_FILE $NEW_DEV_SCHEMA_FILE

echo "--> Modify ./$BASE_PROJECT_NAME$TEST_STR content"

### Replace test folder
OLD_TEST_FOLDER="./$BASE_PROJECT_NAME$TEST_STR"
OLD_TEST_FILE="./$BASE_PROJECT_NAME$TEST_STR/$BASE_PROJECT_NAME$TEST_STR.swift"
NEW_TEST_FOLDER="./$NEW_PROJECT_NAME$TEST_STR"
NEW_TEST_FILE_NAME="$NEW_PROJECT_NAME$TEST_STR.swift"
DEV_STR="DevInfo"
DEV_PLIST="./$BASE_PROJECT_NAME/$BASE_PROJECT_NAME$DEV_STR.plist"
NEW_DEV_PLIST="./$BASE_PROJECT_NAME/$NEW_PROJECT_NAME$DEV_STR.plist"

### Replace unit test content
replace_content_file $OLD_TEST_FILE $BASE_PROJECT_NAME $NEW_PROJECT_NAME

mv $OLD_TEST_FILE "$OLD_TEST_FOLDER/$NEW_TEST_FILE_NAME"
mv $OLD_TEST_FOLDER $NEW_TEST_FOLDER
mv $XCODEPROJ_FILE $NEW_XCODEPROJ_FILE
mv $DEV_PLIST $NEW_DEV_PLIST
mv "./$BASE_PROJECT_NAME" "./$NEW_PROJECT_NAME"

echo "--> Modify Podfile and generate xcworkspace"

### Replace podfile content
PODFILE="Podfile"
rm -rf ./Pods
rm -rf "$BASE_PROJECT_NAME.xcworkspace"
replace_content_file $PODFILE $BASE_PROJECT_NAME $NEW_PROJECT_NAME

pod install

open ./$NEW_PROJECT_NAME.xcworkspace

echo "--> Git init"

rm -rf .git/
git init
git add .
git commit -m "Init Project"

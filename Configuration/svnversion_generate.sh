GIT_VERSION=$(git rev-list --all --count HEAD)
GIT_VERSION=$(($BUILD + 1))

if [ -z "$GIT_VERSION" ]; then
echo "error: git version could not be determined!\nTry running cleanup in the repository"
exit 1
fi

echo "${GIT_VERSION}"

sed 's/\$\$REVISION\$\$/'"${GIT_VERSION}"'/g; s/\$\$WARNING\$\$/IMPORTANT! DO NOT EDIT THIS FILE!/g; s/\$\$INSTRUCTIONS\$\$/Edit Generated_Version.template.xcconfig instead. This file is generated in the Inject Version Numbers target/g' "${PROJECT_DIR}/Configuration/Generated_Version.xcconfig.template" > "${PROJECT_DIR}/GeneratedConfig/Generated_Version.xcconfig"


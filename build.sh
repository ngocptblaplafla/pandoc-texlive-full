# Install pandoc template
cd ./pandoc/templates/
redownload=false

if [ ! -f eisvogel.tex ] || [ $redownload = true ]
then
    EISVOGEL_REPO="https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template"
    EISVOGEL_VERSION="2.4.2"
    wget ${EISVOGEL_REPO}/${EISVOGEL_VERSION}/eisvogel.tex -O eisvogel.tex
fi

# Install pandoc lua filter
cd ../filters

REPO="https://raw.githubusercontent.com/pandoc-ext"

if [ ! -f diagram.lua ] || [ $redownload = true ]
then
    EXT_NAME=diagram
    EXT_VERSION=v1
    wget ${REPO}/${EXT_NAME}/${EXT_VERSION}/_extensions/${EXT_NAME}/${EXT_NAME}.lua -O ${EXT_NAME}.lua
fi

if [ ! -f multibib.lua ] || [ $redownload = true ]
then
    EXT_NAME=multibib
    EXT_VERSION="dd7de577e8e9ebb58f13edc3f7615141552b02c5" # Thanks wlupton to fix bug
    wget ${REPO}/${EXT_NAME}/${EXT_VERSION}/_extensions/${EXT_NAME}/${EXT_NAME}.lua -O ${EXT_NAME}.lua
fi

REPO="https://raw.githubusercontent.com/pandoc/lua-filters/master/"

if [ ! -f include-code-files.lua ] || [ $redownload = true ]
then
EXT_NAME=include-code-files
wget ${REPO}/${EXT_NAME}/${EXT_NAME}.lua -O ${EXT_NAME}.lua
fi

if [ ! -f include-files.lua ] || [ $redownload = true ]
then
EXT_NAME=include-files
wget ${REPO}/${EXT_NAME}/${EXT_NAME}.lua -O ${EXT_NAME}.lua
fi

REPO="https://raw.githubusercontent.com/chrisaga/hk-pandoc-filters/main/"

if [ ! -f tables-rules.lua ] || [ $redownload = true ]
then
EXT_NAME=tables-rules
wget ${REPO}/${EXT_NAME}/${EXT_NAME}.lua -O ${EXT_NAME}.lua
fi

if [ ! -f column-div.lua ] || [ $redownload = true ]
then
EXT_NAME=column-div
wget ${REPO}/${EXT_NAME}/${EXT_NAME}.lua -O ${EXT_NAME}.lua
fi

cd ../../
git submodule update
cp -rf kde-syntax-highlighting/data/syntax pandoc/
cp -rf kde-syntax-highlighting/data/themes pandoc
docker buildx build --platform=linux/amd64,linux/arm64 . --tag pandoc-texlive-full:latest --progress=plain --no-cache --load

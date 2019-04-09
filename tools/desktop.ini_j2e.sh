#!/bin/sh

set -eu
set -x

read -p "フォルダ名の英語化：desktop.ini を書き換えます [y/n] :" YN
case "$YN" in
  "Y" | "y") ;;
  *) exit 1 ;;
esac

for FOLDERPATH in '3D Objects' Desktop Documents Downloads Music Pictures Videos Links Contacts Favorites Searches 'Saved Games'; do
  FILEPATH="$HOME/$FOLDERPATH/desktop.ini"

  if [ -f "$FILEPATH" ]; then
    echo "processing $FILEPATH"

    FILEPATH_BACKUP="$HOME/$FOLDERPATH/desktop.ini.bak"

    # 元の desktop.ini をバックアップします
    cp "$FILEPATH" "$FILEPATH_BACKUP"

    iconv -f utf-16 -t utf-8 <"$FILEPATH_BACKUP" |
      sed 's/^LocalizedResourceName/;LocalizedResourceName/' |
      iconv -f utf-8 -t utf-16 >"$FILEPATH"

    # バックアップを削除
    rm "$FILEPATH_BACKUP"
  fi

done

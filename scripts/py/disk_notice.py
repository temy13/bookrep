#python 3
import os
import requests
import json

url = "https://hooks.slack.com/services/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"
lines = [s.split() for s in os.popen("df -Ph").read().splitlines()]
for l in lines:
    if l[5] == "/" and float(l[4].replace("%", "")) > 50:
        text = "Disk Alert!! Size: " + l[2] + " Used: " + l[3] + " Used: " + l[4]
        requests.post(url, data = json.dumps({
            'text': text,
            'username': u'df -h', # 投稿のユーザー名
            'icon_emoji': u':skull:', # 投稿のプロフィール画像に入れる絵文字
            'link_names': 1, # メンションを有効にする
        }))

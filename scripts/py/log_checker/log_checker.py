#!/usr/bin/env python
import os
import sys
import time
from os.path import dirname, exists

from watchdog.events import FileSystemEventHandler
from watchdog.observers.polling import PollingObserver
import json
import requests
import traceback,sys

url = "https://hooks.slack.com/services/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"


class TailHandler(FileSystemEventHandler):

    def __init__(self, path):
        self.path = path
        self.file = open(path, 'r')
        self.pos = os.stat(path)[6]

    def post(self, text):
        requests.post(url, data = json.dumps({
            'text': text,
            'username': u'Render', # 投稿のユーザー名
            'icon_emoji': u':zombie:', # 投稿のプロフィール画像に入れる絵文字
            'link_names': 1, # メンションを有効にする
        }))


    def close(self):
        self.file.close()

    def check(self):
        self.file.seek(self.pos)
        text = ""
	# for block in iter(lambda: self.file.read(32), ''):
        try:
            text = "".join([block for block in iter(lambda: self.file.read(256), '')])
            for row in text.split("\n"):
                if not row or row == "":
                    continue
                j = json.loads(row)
                print (j["duration"], j["path"])
                if "exception" in j:
                    self.post("Error: " + row)
                if float(j["duration"]) > 350 and j["format"] == "html":
                    self.post("Too Slow: " + row)
        except:
            ex, ms, tb = sys.exc_info()
            print (ex)
            print ("text: ", text)
        finally:
            self.pos = self.file.tell()

    def on_modified(self, event):
        if event.is_directory or self.path != event.src_path:
            return
        self.check()


def tail_like(path):
    observer = PollingObserver()
    handler = TailHandler(path)
    observer.schedule(handler, dirname(path))
    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    finally:
        handler.close()
    observer.join()


def main():
    path = "log/lograge_production.log"
    print (path)
    tail_like(path)


if __name__ == '__main__':
    main()

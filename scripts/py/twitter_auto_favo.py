import os
from os.path import join, dirname
from dotenv import load_dotenv
# import requests
import json
from requests_oauthlib import OAuth1Session
import sys

#.envについて: https://qiita.com/hedgehoCrow/items/2fd56ebea463e7fc0f5b
dotenv_path = join(dirname(__file__), '../../.env')
load_dotenv(dotenv_path)

CK = os.environ.get("TWITTER_KEY")
CS = os.environ.get("TWITTER_SECRET")
AT = os.environ.get("TWITTER_ACCESS")
AS = os.environ.get("TWITTER_ACCESS_SECRET")
twitter = OAuth1Session(CK, CS, AT, AS)
fcount = 200 #max
scount = 100 #max
base = "https://api.twitter.com/1.1"

def get(url):
    try:
      r = twitter.get(url)
      if r.status_code != 200:
          print (url)
          print (r)
          print (r.text)
      data = json.loads(r.text)
      return data
    except:
      print(sys.exc_info())
    return []

def post(url, params):
    try:
      r = twitter.post(url, params)
      if r.status_code != 200:
          print (url)
          print (r)
          print (r.text)
      data = json.loads(r.text)
      return data
    except:
      print(sys.exc_info())
    return []



def get_favo_list():
    baseurl = base + "/favorites/list.json?count=" + str(fcount) + "&screen_name=bookreptokyo"
    favo_list = []
    url = baseurl
    while True:
        data = get(url)
        favo_list.extend([item["id_str"] for item in data])
        if len(data) < fcount: break
        url = base + "/favorites/list.json?count=200&screen_name=bookreptokyo&max_id=" + str(data[-1]["id_str"])
    return set(favo_list)


def favo(query, n, favo_list, rt="mixed"):
    query = query.replace("#", "%23")
    baseurl = base + "/search/tweets.json?q=" + query + "&lang=ja&result_type=" + rt + "&count=" + str(scount) + "&include_entities=true"
    url = baseurl
    for i in range(n):
        data = get(url)
        data = data["statuses"]
        #全てのツイートに対してファボ
        for tweet_id in [item["id_str"] for item in data if item["id_str"] not in favo_list]:
            posturl = base + "/favorites/create.json"
            params = {
                "id": tweet_id
            }
            post(posturl, params)
            favo_list.add(tweet_id)
        if len(data) == 0:
            print (url)
            break
        url = baseurl + "&max_id=" + data[-1]["id_str"]



def main():
    favo_list = get_favo_list()
    favo("#読書好きな人と繋がりたい", 10, favo_list, rt="mixed")
    favo("#おすすめの本教えてください", 10, favo_list, rt="mixed")
    favo("#読書好きな人と繋がりたい", 10, favo_list, rt="recent")
    favo("#おすすめの本教えてください", 10, favo_list, rt="recent")
    favo("#読書好きな人と繋がりたい", 10, favo_list, rt="popular")
    favo("#おすすめの本教えてください", 10, favo_list, rt="popular")



if __name__ == '__main__':
    main()

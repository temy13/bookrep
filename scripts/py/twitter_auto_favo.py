import os
from os.path import join, dirname
#from dotenv import load
from dotenv import load_dotenv
# import requests
import json
from requests_oauthlib import OAuth1Session
import sys
import random
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
is_log = False
# favo_list = []
user_list = []

def get(url):
    try:
      r = twitter.get(url)
      if r.status_code != 200 and is_log:
         print (url)
         print (r)
         print (r.text)
      data = json.loads(r.text)
      return data
    except:
      if is_log:
         print ("error")
         print(sys.exc_info())
      return []

    return []

def post(url, params):
    try:
      r = twitter.post(url, params)
      if r.status_code != 200 and is_log:
          print (url)
          print (r)
          print (r.text)
      data = json.loads(r.text)

      #return data
    except:
      if is_log:
         print ("error")
         print(sys.exc_info())
      #return []
    #return []



def get_favo_list():
    baseurl = base + "/favorites/list.json?count=" + str(fcount) + "&screen_name=bookreptokyo"
    favo_list = []
    url = baseurl
    while True:
        data = get(url)
        favo_list.extend([item["id_str"] for item in data])
        if len(data) < fcount: break
        url = base + "/favorites/list.json?count=200&screen_name=bookreptokyo&max_id=" + str(data[-1]["id_str"])
    return favo_list


def favo(query, n, favo_list, rt="mixed"):
    global user_list
    query = query.replace("#", "%23")
    baseurl = base + "/search/tweets.json?q=" + query + "&lang=ja&result_type=" + rt + "&count=" + str(scount) + "&include_entities=true"
    url = baseurl
    favos = [int(x) for x in favo_list]
    for i in range(n):
        data = get(url)
        data = data["statuses"]
        #全てのツイートに対してファボ
        #for tweet_id in [item["id_str"] for item in data if item["id_str"] not in favo_list and item["id"] not in favos]:
        for tweet_id, uid in [(item["id_str"], item["user"]["id_str"]) for item in data if item["id_str"] not in favos]:
            if uid in user_list:
                continue
            #print (tweet_id)
            posturl = base + "/favorites/create.json"
            params = {
                "id": tweet_id
            }
            post(posturl, params)
            favo_list.append(tweet_id)
            user_list.append(uid)
            if is_log:
                print (tweet_id, uid, "favoed")
        if len(data) == 0:
            #print (url)
            break
        url = baseurl + "&max_id=" + str(data[-1]["id"])
    if is_log:
      print (query, rt, "done")
      print (rt, "done")
    return favo_list

def post_favo(query, n, favo_list):
    favo_list = favo(query, n, favo_list, rt="mixed")
    favo_list = favo(query, n, favo_list, rt="recent")
    favo_list = favo(query, n, favo_list, rt="popular")
    return favo_list

def main():
    favo_list = get_favo_list()
    #print (len(favo_list))
    queries = ["読書好きの人と繋がりたい", "おすすめの本教えてください", "本好きの人と繋がりたい", "読書", "おすすめの本"]
    #queries = ["読書好きの人と繋がりたい", "おすすめの本教えてください", "本好きの人と繋がりたい", "読書"]
    random.shuffle(queries)
    for q in queries:
    	favo_list = post_favo("#" + q, 5, favo_list)



if __name__ == '__main__':
    #sys.exit()
    main()

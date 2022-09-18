import json
import requests
from datetime import date

year = date.today().year
url = f'http://api.themoviedb.org/3/discover/movie?api_key=5fb01ea68e5d90153fd96e994aba787f&primary_release_year={year}&sort_by=popularity.desc'
genres = json.loads(requests.get("https://api.themoviedb.org/3/genre/movie/list?api_key=5fb01ea68e5d90153fd96e994aba787f&language=en-US").text)

data = requests.get(url)
#print(type(data.json()))
#print(data.json()['results'])

genre_id = f'https://api.themoviedb.org/3/discover/movie?api_key=5fb01ea68e5d90153fd96e994aba787f&with_genres=28&sort_by=popularity.desc'
data_1 = json.loads(requests.get(genre_id).text)
print(data_1)
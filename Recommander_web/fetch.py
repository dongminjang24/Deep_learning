# import requests

# name = input('어떤 영화의 포스터 주소를 원하십니까')
# result = requests.get(f"https://api.themoviedb.org/3/search/movie?api_key=da396cb4a1c47c5b912fda20fd3a3336&language=en-US&query={name}&page=1&include_adult=false")

# #print(result.json()['results'][0])

# print(f"http://image.tmdb.org/t/p/w200{result.json()['results'][0]['poster_path']}") # 영화 이름만 바꿔주면 해당 영화의 포스터 이미지 주소를 알려준다. 

# Importing libs
import requests
import json

# Main dictionary
movie_dict = {}

# Main movie class
class movie:
    def __init__(self,id="",title="None",poster_url="None",score="None",date="None",overview="None",back_drop="None"):
        self.id = id
        self.title = title
        self.poster = "http://image.tmdb.org/t/p/w200" + str(poster_url)
        self.score = score
        self.date = date
        self.overview = overview
        self.back_drop = "http://image.tmdb.org/t/p/w200" + str(back_drop)


class movie_collection:
    def __init__(self,results=[]):
        self.results = results
    def fetch(self,url):
        results = json.loads(requests.get(url).text)["results"]
        
        # print(results)
        for i in results:
            if i["id"] and i["title"] and i["poster_path"] and i["vote_average"] and i["release_date"] and i["overview"] and i["backdrop_path"]:
                self.results.append(movie(i["id"],i["title"],i["poster_path"],i["vote_average"],i["release_date"],i["overview"],i["backdrop_path"]))

    
# if __name__=="__main__":
#     mov = movie_collection().fetch("http://api.themoviedb.org/3/search/movie?api_key=15d2ea6d0dc1d476efbca3eba2b9bbfb&query=spiderman")
#     for i in mov.results:
#         print(i.id,i.title,i.poster,i.score,i.date,i.overview,i.back_drop)
#         print()

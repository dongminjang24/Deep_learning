import pandas as pd
from ast import literal_eval
from sklearn.feature_extraction.text import TfidfVectorizer, CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity

df2 = pd.read_csv('./datasets/tmdb_5000_movies.csv')
df2 = df2.reset_index()

df2['genres']= df2['genres'].apply(literal_eval)
df2['keywords']= df2['keywords'].apply(literal_eval)

df2['genres'] = df2['genres'].apply(lambda x : [y['name'] for y in x])
df2['keywords'] = df2['keywords'].apply(lambda x : [y['name'] for y in x])
df2['genres_literal'] = df2['genres'].apply(lambda x : (' ').join(x))
# print(df2)
C = df2['vote_average'].mean()
m = df2['vote_count'].quantile(0.6)
def weighted_vote_average(record):
    v = record['vote_count']
    R = record['vote_average']
    return((v/(v+m))*R) + ((m/(m+v))*C) # 가중평점을 return값으로 돌려준다


def find_sim_movie_ver2(df, sorted_ind, title_name, top_n=10):
    title_movie = df[df['title'] == title_name]
    title_index = title_movie.index.values
    # top_n의 2배에 해당하는 장르 유사성이 높은 index 추출
    similar_indexes = sorted_ind[title_index, :(top_n*2)]
    # 기준 영화 index는 제외
    similar_indexes = similar_indexes[similar_indexes != title_index]
    # top_n의 2배에 해당한느 후보군에서 weighted_vote 높은 순으로 top_n을 만큼 추출
    return df.iloc[similar_indexes].sort_values('weighted_vote', ascending=False)[:top_n]



class RECOMMAND():
    def __init__(self, vectorizer):
        self.vectorizer = vectorizer
    
    def get_recommandation(self ,title ,df=df2):
        # print(df)
        count_vec = self.vectorizer(stop_words="english")
        genres_matrics = count_vec.fit_transform(df['genres_literal'])
        genre_sim = cosine_similarity(genres_matrics ,genres_matrics )
        genre_sim_sorted = genre_sim.argsort()[:, ::-1]


        df['weighted_vote'] = df.apply(weighted_vote_average, axis=1)
        # C; 전체 영화에 대한 평균평점 = 약 6점
        # m: 평점을 부여하기 위한 최소 투표 횟수 = 370회(상위 60% 수준)

        similar_movies = find_sim_movie_ver2(df, genre_sim_sorted, title, 10)
        print(similar_movies['release_date'])
        return_df = pd.DataFrame(columns=['Title', 'Year'])
        return_df['Title'] = similar_movies['title']
        return_df['Year'] = similar_movies['release_date']
        # print(return_df)
        return return_df

# recommander = RECOMMAND(TfidfVectorizer)

# recommander.get_recommandation("Avatar")






# # print(genre_sim_sorted[0:10])



# print('C:', round(C, 3), 'm:', round(m,3))

# # 기존 데이터에 가중평점 칼럼 추가

# # 먼저 장르 유사성이 높은 영화 20개 선정 후, 가중평점순으로 10개 선정

# # godfather에 대해 장르 유사성, 가중평점 반영한 추천 영화 10개를 뽑아보자

# print(similar_movies[['title', 'vote_average', 'weighted_vote', 'genres', 'vote_count']])
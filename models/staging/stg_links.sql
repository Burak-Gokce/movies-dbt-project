with source as (

    select *
    from {{ source('movies_raw', 'links') }}

),

cleaned as (

    select
        movieId as movie_id,
        imdbId as imdb_id,
        tmdbId as tmdb_id

    from source

)

select *
from cleaned
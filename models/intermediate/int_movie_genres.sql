with movies as (

    select
        movie_id,
        title,
        release_date,
        vote_average,
        vote_count,
        genres

    from {{ ref('stg_movies_metadata') }}

    where genres is not null

),

genre_names as (

    select
        movie_id,
        title,
        release_date,
        vote_average,
        vote_count,

        regexp_extract_all(
            genres,
            r"'name': '([^']+)'"
        ) as genre_array

    from movies

),

unnested as (

    select
        movie_id,
        title,
        release_date,
        extract(year from release_date) as release_year,
        vote_average,
        vote_count,
        genre_name

    from genre_names,
    unnest(genre_array) as genre_name

)

select *
from unnested
with genres as (

    select
        movie_id,
        title,
        genre_name,
        vote_average,
        vote_count

    from {{ ref('int_movie_genres') }}

),

filtered as (

    select
        movie_id,
        title,
        genre_name,
        vote_average,
        vote_count

    from genres

    where vote_average is not null
      and vote_count >= 50

)

select *
from filtered
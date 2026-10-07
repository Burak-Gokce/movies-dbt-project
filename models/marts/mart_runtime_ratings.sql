with runtime_ratings as (

    select
        movie_id,
        title,
        release_date,
        runtime,
        runtime_group,
        vote_average,
        vote_count

    from {{ ref('int_movie_runtime_ratings') }}

),

filtered as (

    select
        movie_id,
        title,
        release_date,
        runtime,
        runtime_group,
        vote_average,
        vote_count

    from runtime_ratings

    where vote_count >= 50

)

select *
from filtered
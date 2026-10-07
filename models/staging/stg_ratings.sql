with source as (

    select *
    from {{ source('movies_raw', 'ratings') }}

),

cleaned as (

    select
        userId as user_id,
        movieId as movie_id,
        rating,
        timestamp as rating_timestamp

    from source

)

select *
from cleaned
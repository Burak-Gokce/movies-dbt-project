with source as (

    select distinct *
    from {{ source('movies_raw', 'keywords') }}

),

cleaned as (

    select
        id as movie_id,
        nullif(trim(keywords), '[]') as keywords_data

    from source

)

select *
from cleaned
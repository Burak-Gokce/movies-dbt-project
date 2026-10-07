with source as (

    select distinct *
    from {{ source('movies_raw', 'credits') }}

),

cleaned as (

    select
        id as movie_id,

        nullif(trim(`cast`), '[]') as cast_data,
        nullif(trim(crew), '[]') as crew_data

    from source

),

deduplicated as (

    select *
    from cleaned

    qualify row_number() over (
        partition by movie_id
        order by crew_data desc nulls last
    ) = 1

)

select *
from deduplicated
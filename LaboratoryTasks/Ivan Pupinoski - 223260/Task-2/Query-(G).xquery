let $all_rentals := doc("Rent.xml")//RENT

let $album_rental_counts :=
  for $album in doc("Albums.xml")//ALBUM
  let $album_id := $album/@ID
  let $artist_id := $album/@ARTIST_ID
  let $rental_count := count(
    for $rent in $all_rentals
    let $cd_id := $rent/@CD_ID
    where doc("CatalogCD.xml")//CD[@ID = $cd_id and @ALBUM_ID = $album_id]
    return $rent
  )
  let $has_available_cd := 
    some $cd in doc("CatalogCD.xml")//CD[@ALBUM_ID = $album_id] 
    satisfies ($cd/OCCUPIED = "0" or string($cd/OCCUPIED) = "free" or string($cd/OCCUPIED) = "0")
  where $has_available_cd
  order by $rental_count descending
  return
    <ALBUM_GROUP>
      <ALBUM_ID>{data($album_id)}</ALBUM_ID>
      <ARTIST_ID>{data($artist_id)}</ARTIST_ID>
      <RENTAL_COUNT>{$rental_count}</RENTAL_COUNT>
    </ALBUM_GROUP>

let $top_album := $album_rental_counts[1]
let $group_id := $top_album/ARTIST_ID/text()
let $group := doc("Groups.xml")//GROUP[@ID = $group_id]

return
  <RESULT>
    <GROUP_ID>{data($group/@ID)}</GROUP_ID>
    <YEAR_FORMED>{$group/YEAR_FORMED/text()}</YEAR_FORMED>
    <NUMBER_OF_MEMBERS>{$group/NUMBER_OF_MEMBERS/text()}</NUMBER_OF_MEMBERS>
    <TOP_ALBUM_ID>{$top_album/ALBUM_ID/text()}</TOP_ALBUM_ID>
    <RENTAL_COUNT>{$top_album/RENTAL_COUNT/text()}</RENTAL_COUNT>
  </RESULT>
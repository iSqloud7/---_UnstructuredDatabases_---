let $albums := doc("Albums.xml")//ALBUM
let $catalog := doc("CatalogCD.xml")//CD
let $rents := doc("Rent.xml")//RENT

return
  for $album in $albums
  let $album_id := $album/@ID
  let $cds := $catalog[@ALBUM_ID = $album_id]
  let $cd_ids := $cds/@ID
  let $rent_count := count(
    for $r in $rents
    where some $id in $cd_ids satisfies $r/@CD_ID = $id
    return $r
  )
  let $cd_count := count($cd_ids)
  let $average := 
    if ($cd_count > 0) then
      round($rent_count div $cd_count * 100) div 100
    else
      0
  return
    <AlbumAverage>
      <AlbumID>{ $album_id }</AlbumID>
      <Name>{ $album/NAME/text() }</Name>
      <CD_Count>{ $cd_count }</CD_Count>
      <TotalRentals>{ $rent_count }</TotalRentals>
      <AverageRentalsPerCD>{ $average }</AverageRentalsPerCD>
    </AlbumAverage>

for $artist in doc("artists.xml")/ARTISTS/ARTIST
let $albums := doc("albums.xml")/ALBUMS/ALBUM[@ARTIST_ID = $artist/@ID]
return
<ArtistInfo>
    {$artist}
    <Albums>
        {
            for $album in $albums
            return
                <Album>
                    <Name>{$album/NAME/text()}</Name>
                    <ReleaseYear>
                        {if ($album/RELEASE_YEAR) then $album/RELEASE_YEAR/text() else "N/A"}
                     
                    </ReleaseYear>
                </Album>
        }
    </Albums>
</ArtistInfo>
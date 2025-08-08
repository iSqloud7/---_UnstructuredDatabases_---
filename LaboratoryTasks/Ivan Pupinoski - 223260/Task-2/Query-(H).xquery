let $short_term_renters :=
    for $client in doc("Clients.xml")//CLIENT
    let $client_id := $client/@ID
    where some $rent in doc("Rent.xml")//RENT[@CLIENT_ID=$client_id]
        satisfies
        let $from_date_parts := tokenize($rent/FROM_DATE,'/')
        let $return_date_parts := tokenize($rent/RETURN_DATE, '/')
        let $from_date := 
            if (count($from_date_parts) = 3 and 
                string-length($from_date_parts[3]) >= 4 and 
                string-length($from_date_parts[1]) > 0 and 
                string-length($from_date_parts[2]) > 0) 
            then xs:date(concat($from_date_parts[3], '-', $from_date_parts[1], '-', $from_date_parts[2]))
            else ()
        let $return_date := 
            if (count($return_date_parts) = 3 and 
                string-length($return_date_parts[3]) >= 4 and 
                string-length($return_date_parts[1]) > 0 and 
                string-length($return_date_parts[2]) > 0) 
            then xs:date(concat($return_date_parts[3], '-', $return_date_parts[1], '-', $return_date_parts[2]))
            else ()
        return 
            if (exists($from_date) and exists($return_date)) then
                days-from-duration($return_date - $from_date) < 10
            else
                false()
    return $client
    
return
    <SHORT_TERM_RENTERS>
        {
        for $client in $short_term_renters
        return
            <CLIENT>
                <ID>{$client/@ID}</ID>
                {
                    if ($client/NAME) then
                        <NAME>{$client/NAME/text()}</NAME>
                    else
                        <NAME>{$client/BASIC_INFO/NAME/text()}</NAME>
                }
                {
                    if($client/SURNAME) then
                        <SURNAME>{$client/SURNAME/text()}</SURNAME>
                    else
                        <SURNAME>{$client/BASIC_INFO/SURNAME/text()}</SURNAME>
                }
                {
                    if ($client/EMAIL) then
                        <EMAIL>{$client/EMAIL/text()}</EMAIL>
                    else ()
                }
            </CLIENT>
        }
    </SHORT_TERM_RENTERS>
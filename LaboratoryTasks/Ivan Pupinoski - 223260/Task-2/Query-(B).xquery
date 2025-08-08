let $clients := distinct-values(doc("Rent.xml")//RENT/@CLIENT_ID)
let $result :=
    for $client_id in $clients
    let $rental_count := count(doc("Rent.xml")//RENT[@CLIENT_ID = $client_id])
    order by $rental_count descending
    return
        <CLIENT>
            <CLIENT_ID>{data($client_id)}</CLIENT_ID>
            <RENTAL_COUNT>{$rental_count}</RENTAL_COUNT>
        </CLIENT>
return subsequence($result, 1, 3)
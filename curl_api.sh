#!/bin/bash

# Examples:

# 0. export API_KEY=api_key_string

# 1. Cache status for domain cachoid.com
# sh curl_api.sh $API_KEY cachoid.com

# 2. Cache status for domain cachoid.com and subpage /support
# sh curl_api.sh $API_KEY cachoid.com support

urlencode() {
    # urlencode <string>
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C
    
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done
    
    LC_COLLATE=$old_lc_collate
}

urldecode() {
    # urldecode <string>

    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
}

set -x;

if [ ${#} -lt '2' ];
then
	echo "$0 <token> <fqdn> [<subpage>]";
else
	if [ ${#} -eq '2' ];
	then
		curl -XGET -vvv -H "Accept: application/vnd.cachoid.v1+json" -H "Authorization: Bearer $1" https://api.cachoid.com/cache/status/$(urlencode $2)
	else
		curl -XGET -vvv -H "Accept: application/vnd.cachoid.v1+json" -H "Authorization: Bearer $1" https://api.cachoid.com/cache/status/$(urlencode $2)/$(urlencode $3)
	fi
fi
